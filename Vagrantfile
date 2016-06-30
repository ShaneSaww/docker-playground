# -*- mode: ruby -*-
# vi: set ft=ruby :
NODE_COUNT = 2
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "master", primary: true do |master|
    master.vm.network "private_network", ip: "10.20.1.10"
    master.vm.provision "ansible" do |ansible|
      ansible.playbook = "swarm_master.yml"
    end
  end

  (1..NODE_COUNT).each do |i|
    config.vm.define "node-#{i}" do |node|
      node.vm.network "private_network", ip: "10.20.1.1#{i}"
      node.vm.provision "ansible" do |ansible|
        ansible.limit = "all"
        ansible.playbook = "swarm_node.yml"
      end
    end
  end
end
