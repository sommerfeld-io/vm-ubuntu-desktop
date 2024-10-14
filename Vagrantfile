# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = "bento/ubuntu-24.04" # https://portal.cloud.hashicorp.com/vagrant/discover/bento/ubuntu-24.04
VM_HOSTNAME = "vm-ubuntu-vagrant"

Vagrant.configure("2") do |config|
  config.vm.box = BOX_NAME
  config.vm.hostname = VM_HOSTNAME

  config.vm.provider "virtualbox" do |v|
    v.memory = "2048"
    v.cpus = 2
    v.name = VM_HOSTNAME
  end

  config.vm.provision "shell", path: "provision/bootstrap.sh"
end
