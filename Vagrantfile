# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # config.vm.network "public_network"

  config.vm.synced_folder "./", "/vagrant", type: "rsync"
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "shell", inline: <<-SHELL
    yum install -y wget vim
    wget https://yum.puppet.com/puppet5-release-el-7.noarch.rpm
    rpm -Uvh puppet5-release-el-7.noarch.rpm
    yum -y --nogpgcheck install puppet-agent
    ln -s /vagrant /opt/puppetlabs/puppet/modules/freepbx
    /opt/puppetlabs/bin/puppet module install puppet-archive --version 4.5.0
    /opt/puppetlabs/bin/puppet module install puppet-nodejs --version 8.0.0
    /opt/puppetlabs/bin/puppet module install puppet-selinux --version 3.2.0
    /opt/puppetlabs/bin/puppet module install puppet-yum --version 4.2.0
    /opt/puppetlabs/bin/puppet module install puppetlabs-augeas_core --version 1.0.5
    /opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --version 6.3.0
    /opt/puppetlabs/bin/puppet module install puppetlabs-translate --version 2.2.0
    /opt/puppetlabs/bin/puppet apply /vagrant/tests

  SHELL
end
