## Run everything as sudo
#chmod 777 ./setup.sh
#apt-get update
#apt-get -y upgrade
#apt-get -y install git
#apt-get -y install virtualenv
#apt -y autoremove

git clone https://github.com/Mierdin/jinja2-nxos-config.git config
#apt-get -y install isc-dhcp-server
#cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd_bak.conf
#echo 'default-lease-time 3600;' > /etc/dhcp/dhcpd.conf
#echo 'authoritative;' >> /etc/dhcp/dhcpd.conf
#echo 'max-lease-time 3600;' >> /etc/dhcp/dhcpd.conf
#echo 'ddns-update-style none;' >> /etc/dhcp/dhcpd.conf
#echo 'subnet 10.1.1.0 netmask 255.255.255.0 {' >> /etc/dhcp/dhcpd.conf
#echo '    range 10.1.1.10 10.1.1.250;' >> /etc/dhcp/dhcpd.conf
#echo '}' >> /etc/dhcp/dhcpd.conf
#service isc-dhcp-server restart
#echo 'source-directory /etc/network/interfaces.d' > /etc/network/interfaces
#echo 'auto lo' >> /etc/network/interfaces
#echo 'iface lo inet loopback' >> /etc/network/interfaces
#echo 'auto enxb827ebfb8e94' >> /etc/network/interfaces
#echo 'iface enxb827ebfb8e94 inet static' >> /etc/network/interfaces
#echo '    address 10.1.1.1' >> /etc/network/interfaces
#echo '    netmask 255.255.255.0' >> /etc/network/interfaces
#ifdown enxb827ebfb8e94 && ifup enxb827ebfb8e94
#ifconfig | grep addr
#mkdir ../tftpboot
#virtualenv .
#pip install jinja2

#apt-get -y install xinetd tftpd tftp
#echo 'service tftp' > /etc/xinetd.d/tftp
#echo '{' >> /etc/xinetd.d/tftp
#echo 'protocol = udp' >> /etc/xinetd.d/tftp
#echo 'port = 69' >> /etc/xinetd.d/tftp
#echo 'socket_type = dgram' >> /etc/xinetd.d/tftp
#echo 'wait = yes' >> /etc/xinetd.d/tftp
#echo 'server = /usr/sbin/in.tftpd' >> /etc/xinetd.d/tftp
#echo 'server_args = /home/james/comware/tftpboot' >> /etc/xinetd.d/tftp
#echo 'disable = no' >> /etc/xinetd.d/tftp
#echo 'user = nobody' >> /etc/xinetd.d/tftp
#echo '}' >> /etc/xinetd.d/tftp
#mkdir /home/james/comware/tftpboot
#chmod -R 777 /home/james/comware/tftpboot
#chown -R nobody /home/james/comware/tftpboot
#service xinetd restart

#apt-get -y install vsftpd
#cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
#sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf
#sed -i 's/#local_umask/local_umask/' /etc/vsftpd.conf
#sed -i 's/#chroot_local_user/chroot_local_user/' /etc/vsftpd.conf
#echo 'allow_writeable_chroot=YES' >> /etc/vsftpd.conf
#echo 'pasv_enable=YES' >> /etc/vsftpd.conf
#echo 'pasv_min_port=40000' >> /etc/vsftpd.conf
#echo 'pasv_max_port=40100' >> /etc/vsftpd.conf
#service vsftpd restart



#something wrong with vsftp -james
netstat -plnut4
