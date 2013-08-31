require 'fileutils'

# Ensure that module is namespaced with plugin name
module SshStaticKeys
  # Example: Create new instance and class methods on Foreman's Host model
  module Host::ManagedExtensions
    extend ActiveSupport::Concern

    included do

      def host_ssh_key
        config = {
          'name'   => self.ip,
          'dir'    => 'ssh',
          'type'   => 'rsa',
          'size'   => 2048,
        }

        config['size'] = 1024 if config['type'] == 'dsa' and config['size'] > 1024

        fullpath = Rails.root.join('tmp','ssh_keys').to_s

        # Make sure to write out a directory to init if necessary
        begin
          if !File.directory? fullpath
            FileUtils.mkdir_p fullpath
          end
        rescue => e
          raise ::ForemanException.new("SshStaticKeys: Unable to setup ssh keystore directory: (#{e})")
        end

        # Do my keys exist? Well, keygen if they don't!
        begin
          unless File.exists?("#{fullpath}/#{config['name']}") then
            %x[/usr/bin/ssh-keygen -t #{config['type']} -b #{config['size']} -P '' -f #{fullpath}/#{config['name']}]
          end
        rescue => e
          raise ::ForemanException.new("SshStaticKeys: Unable to generate ssh key (#{e})")
        end

        # Return ssh key content based on request
        keys = {}
        begin
          pub_key = File.open("#{fullpath}/#{config['name']}.pub").read
          keys['public'] = pub_key.scan(/^.* (.*) .*$/)[0][0]
          keys['private'] =  File.open("#{fullpath}/#{config['name']}").read
        rescue => e
          raise ::ForemanException.new("SshStaticKeys: Unable to read ssh key (#{e})")
        end

        return keys

      end

    end
  end
end
