#!/data/data/com.termux/files/usr/bin/bash
pkg install proot wget
wget https://cdimage.ubuntu.com/ubuntu-base/releases/22.04/release/ubuntu-base-22.04.1-base-armhf.tar.gz
mkdir linux
cd linux 
tar -xvf ../ubuntu-base-22.04.1-base-armhf.tar.gz
cd ..
cat > /data/data/com.termux/files/home/.termux/boot/linux << "EOF"
unset LD_PRELOAD
proot -r /data/data/com.termux/files/home/linux -b /dev -b /sys -b /proc  /bin/bash /init.sh
EOF
echo "nameserver 1.1.1.1" > /data/data/com.termux/files/home/linux/etc/resolv.conf
cat > /data/data/com.termux/files/home/linux/init.sh << "EOF"
#!/bin/bash
exec /bin/bash
EOF
chmod 777 linux/init.sh
