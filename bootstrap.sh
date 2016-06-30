#!/bin/sh
NODE_COUNT=2

kill_all(){
  VBoxManage list runningvms | awk '{print $2;}' \
  | xargs -I vmid VBoxManage controlvm vmid poweroff
}

master(){
  vagrant up master --no-provision
  vagrant provision master

}

nodes ()
{
  for (( c=1; c<=$NODE_COUNT; c++ ))
  do
    vagrant up node-$c --no-provision
  done

  for (( c=1; c<=$NODE_COUNT; c++ ))
  do
    sleep NODE_COUNT
    echo "Staging Parallel Provision"
    echo "node-$c"
  done | xargs -P $NODE_COUNT -I"BOXNAME" \
      sh -c 'vagrant provision BOXNAME >tmp/BOXNAME.out.txt 2>&1 || echo "Error Occurred: BOXNAME"'

}
all(){
  master
  nodes
}
case "$1" in
    "all") all;;
    "master") master;;
    "nodes") nodes;;
    "kill") kill_all;;
    *) exit
esac
