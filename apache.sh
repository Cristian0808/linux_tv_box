#!/bin/bash
wget https://dlcdn.apache.org/httpd/httpd-2.4.54.tar.gz
tar -xvf httpd-2.4.54.tar.gz
cd httpd-2.4.54
./configure --prefix=$(pwd)/apache --exec-prefix=$(pwd)/apache
make -j2
make install
 
