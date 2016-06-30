#!/bin/sh
NODE_COUNT=2

vmkill_all(){
  VBoxManage list runningvms | awk '{print $2;}' \
  | xargs -I vmid VBoxManage controlvm vmid poweroff
}

master(){
  vagrant up master --no-provision
  vagrant provision master

}

nodes ()
{
    vagrant up /node-[0-$NODE_COUNT]/ --no-provision
    vagrant up  /node-[0-$NODE_COUNT]/
}
all(){
  master
  nodes
}

case "$1" in
    "all") all;;
    "master") master;;
    "nodes") nodes;;
    "vm-kill") vmkill_all;;
    *) exit
esac
