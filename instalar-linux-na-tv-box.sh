#!/data/data/com.termux/files/usr/bin/bash
cd /data/data/com.termux/files/home
wget https://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.5-base-armhf.tar.gz -O ubuntu-base-20.04.5-base-armhf.tar.gz 
mkdir ubuntu-filesystem
cd ubuntu-filesystem
tar --ignore-command-error  -xvf ../ubuntu-base-20.04.5-base-armhf.tar.gz 
cd ..
cat >> ubuntu-filesystem/root/.bashrc << EOF
echo 'nameserver 1.1.1.1' > /etc/resolv.conf
apt-get update
apt-get install dropbear icecast2 -y
adduser padrao
groupadd -g 33 sshd
useradd -u 33 -g 33 -c sshd -d / sshd
wget https://pastebin.com/raw/8SU2PQGV -O /etc/icecast2/icecast.xml
echo "padrao   ALL=(ALL:ALL) ALL" >> /etc/sudoers
EOF
cat > /data/data/com.termux/files/home/.termux/boot/linux << "EOF"
#!/data/data/com.termux/files/usr/bin/sh
rm /data/data/com.termux/files/home/ubuntu-filesystem/root/.bashrc
rm /data/data/com.termux/files/home/.termux/boot/instalacao
unset LD_PRELOAD
proot -r /data/data/com.termux/files/home/ubuntu-filesystem -0 -w / -b /dev -b /proc -b /sys /init.sh
EOF
cat > /data/data/com.termux/files/home/ubuntu-filesystem/init.sh << "EOF"
#!/bin/bash
export PATH=/usr/bin:/bin:/usr/sbin:/usr/bin:/sbin:${PATH}
export HOME=/root
dropbear -p 2222
icecast2 -b -c /etc/icecast2/icecast.xml
exec /bin/bash
EOF
chmod 777 /data/data/com.termux/files/home/ubuntu-filesystem/init.sh
unset LD_PRELOAD
proot -r /data/data/com.termux/files/home/ubuntu-filesystem -0 -w / -b /dev -b /proc -b /sys /init.sh
