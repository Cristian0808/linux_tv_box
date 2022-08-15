#!/data/data/com.termux/files/usr/bin/bash
pkg install proot wget
wget https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.1-base-armhf.tar.gz
mkdir linux
cd linux 
tar -xvf ../ubuntu-base-22.04.1-base-armhf.tar.gz
cd ..
cat > .termux/boot/linux << "EOF"
unset LD_PRELOAD
proot -w /data/data/com.termux/files/home/linux -b /dev -b /sys -b /proc /init.sh
EOF
cat > linux/init.sh << "EOF"
exec /etc/rc.local
exec /bin/bash
EOF
chmod 777 linux/init.sh
