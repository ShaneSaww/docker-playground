# -*- mode: ruby -*-
# vi: set ft=ruby :
MASTER_COUNT = 1
NODE_COUNT = 2
total_machine_count = (MASTER_COUNT+NODE_COUNT)
start_count = 1
##Doing this(bewlow) will allow me provision just the nodes or just the master
##Without this running vagrant provision * will fail as machine_id will never == total count
if !ARGV.empty?
  if ARGV.any?{|args| args.match(/^master/)}
    total_machine_count = MASTER_COUNT
  elsif ARGV.any?{|args| args.match(/^node/)}
    start_count = NODE_COUNT
  end
end
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  (start_count..total_machine_count).each do |machine_id|
    if machine_id <= MASTER_COUNT
      machine_name = "master-#{machine_id}"
    elsif machine_id >= NODE_COUNT
      machine_name = "node-#{machine_id}"
    end
      config.vm.define "#{machine_name}", primary: true do |machine|
        machine.vm.network "private_network", ip: "10.20.1.#{10+machine_id}"
        machine.vm.network "private_network", ip: "10.20.1.#{10+machine_id}"
      if machine_id == total_machine_count
        machine.vm.provision "ansible" do |ansible|
          ansible.limit = "all"
          ansible.playbook = "docker_install.yml"
        end
        machine.vm.provision "ansible" do |ansible|
          ansible.limit = "all"
          ansible.playbook = "swarm_master.yml"
          ansible.raw_arguments = ["--connection=paramiko"]
        end
        machine.vm.provision "ansible" do |ansible|
          ansible.limit = "all"
          ansible.playbook = "swarm_node.yml"
          ansible.raw_arguments = ["--connection=paramiko"]
        end
      end
    end
  end
end
