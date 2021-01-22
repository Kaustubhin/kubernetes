#!/bin/bash

echo "[TASK 1] Install NFS server"
sudo apt-get install nfs-kernel-server portmap -y

echo "[TASK 2] Create NFS share"
sudo mkdir /opt/share/kubedata
sudo chown nobody:nogroup /opt/share/kubedata

echo "[TASK 3] Stop and Disable firewall"
systemctl disable --now ufw >/dev/null 2>&1

echo "[TASK 4] Add NFS server path"
cat >>/etc/exports<<EOF
/opt/share/kubedata     172.16.16.104(rw,sync,no_subtree_check)
EOF

echo "[TASK 5] Exports NFS path"
sudo exportfs -a
sudo exportfs -v