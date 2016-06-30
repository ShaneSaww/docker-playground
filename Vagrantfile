# -*- mode: ruby -*-
# vi: set ft=ruby :
MASTER_COUNT = 1
NODE_COUNT = 2
TOTAL_COUNT = (MASTER_COUNT+NODE_COUNT)
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  (1..TOTAL_COUNT).each do |machine_id|
    if machine_id <= MASTER_COUNT
      machine_name = "master-#{machine_id}"
    elsif machine_id >= NODE_COUNT
      machine_name = "node-#{machine_id}"
    end
      config.vm.define "#{machine_name}", primary: true do |machine|
        machine.vm.network "private_network", ip: "10.20.1.#{10+machine_id}"
        machine.vm.network "private_network", ip: "10.20.1.#{10+machine_id}"
      if machine_id == TOTAL_COUNT
        machine.vm.provision "ansible" do |ansible|
          ansible.limit = "all"
          ansible.playbook = "docker_install.yml"
        end
        machine.vm.provision "ansible" do |ansible|
          ansible.limit = "master-*"
          ansible.playbook = "swarm_master.yml"
        end
        machine.vm.provision "ansible" do |ansible|
          ansible.limit = "node-*"
          ansible.playbook = "swarm_node.yml"
        end
      end
    end
  end
end
