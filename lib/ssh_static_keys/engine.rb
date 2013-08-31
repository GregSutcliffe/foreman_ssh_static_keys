require 'ssh_static_keys'

module SshStaticKeys
  #Inherit from the Rails module of the parent app (Foreman), not the plugin.
  #Thus, inhereits from ::Rails::Engine and not from Rails::Engine
  class Engine < ::Rails::Engine

    initializer 'ssh_static_keys.helper' do |app|
      #ActionView::Base.send :include, SshStaticKeys::HostsHelper

      # Extend core HostHelper to add rows to Properties on hosts/show
      ::Host::Managed.send :include, Host::ManagedExtensions
    end

  end
end
