# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "precise64"
  config.vm.box_url = "file:///Users/hess/Projects/boxes/precise64.box"

  config.vm.network :forwarded_port, guest: 80, host: 8081

  config.vm.provision :shell, :inline => "echo \"America/Chicago\" | sudo tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata"

  config.vm.synced_folder ".", "/vagrant",
    owner: "vagrant", 
    group: "vagrant" 

  config.vm.provision :shell, :path => "bootstrap.sh"


end
