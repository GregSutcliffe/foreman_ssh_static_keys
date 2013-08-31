# SshStaticKeys

A quick plugin to generate SSH keys based on the Host's IP.

# Installation

As per usual for plugins...

# Usage

Put something like this in your template:

    echo <%= @host.host_ssh_key['private'] %> > /etc/ssh/ssh_host_rsa_key
    echo "ssh-rsa <%= @host.host_ssh_key['public'] %> foreman" > /etc/ssh/ssh_host_rsa_key.pub

Rebuild the host.

# Author

Greg Sutcliffe <greg.sutcliffe@gmail.com>
