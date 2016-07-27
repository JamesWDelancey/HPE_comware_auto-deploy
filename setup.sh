## Run everything as sudo
#chmod 777 ./setup.sh
#apt-get update
#apt-get -y upgrade
#apt-get -y install git
#apt-get -y install python-pip
#apt -y autoremove

#apt-get -y install isc-dhcp-server
#cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd_bak.conf
#echo 'default-lease-time 3600;' > /etc/dhcp/dhcpd.conf
#echo 'authoritative;' >> /etc/dhcp/dhcpd.conf
#echo 'max-lease-time 3600;' >> /etc/dhcp/dhcpd.conf
#echo 'ddns-update-style none;' >> /etc/dhcp/dhcpd.conf
#echo 'subnet 172.20.0 netmask 255.255.255.0 {' >> /etc/dhcp/dhcpd.conf
#echo '    range 172.20.0.10 172.20.0.250;' >> /etc/dhcp/dhcpd.conf
#echo '    option tftp-server-name "172.20.0.3";' >> /etc/dhcp/dhcpd.conf
#echo '    option bootfile-name "boot.py";' >> /etc/dhcp/dhcpd.conf
#echo '}' >> /etc/dhcp/dhcpd.conf
#service isc-dhcp-server restart
#echo 'source-directory /etc/network/interfaces.d' > /etc/network/interfaces
#echo 'auto lo' >> /etc/network/interfaces
#echo 'iface lo inet loopback' >> /etc/network/interfaces
#echo 'auto ens33' >> /etc/network/interfaces
#echo 'iface ens33 inet static' >> /etc/network/interfaces
#echo '    address 172.20.0.3' >> /etc/network/interfaces
#echo '    netmask 255.255.255.0' >> /etc/network/interfaces
#Edit these for your environment
#ifdown ens33 && ifup ens33
#ifconfig | grep addr
#pip install pyyaml
#echo $PATH

#apt-get -y install xinetd tftpd tftp
#echo 'service tftp' > /etc/xinetd.d/tftp
#echo '{' >> /etc/xinetd.d/tftp
#echo 'protocol = udp' >> /etc/xinetd.d/tftp
#echo 'port = 69' >> /etc/xinetd.d/tftp
#echo 'socket_type = dgram' >> /etc/xinetd.d/tftp
#echo 'wait = yes' >> /etc/xinetd.d/tftp
#echo 'server = /usr/sbin/in.tftpd' >> /etc/xinetd.d/tftp
#echo 'server_args = /home/rick/HPE/tftpboot' >> /etc/xinetd.d/tftp
#echo 'disable = no' >> /etc/xinetd.d/tftp
#echo 'user = nobody' >> /etc/xinetd.d/tftp
#echo '}' >> /etc/xinetd.d/tftp
#Edit these to match your tftpboot directory
#chmod -R 777 /home/rick/HPE/tftpboot
#chown -R nobody /home/rick/HPE/tftpboot
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

netstat -plnut4

#chmod 777 tftpboot/boot.py

#only for raspberry pi
#serial adapter is /dev/ttyUSB0 on raspberry pi
#apt-get -y remove brltty
#apt-get -y install minicom

#This command converts YAML to JSON to be read by the Comware 7 swithches
python -c 'import sys, yaml, json; json.dump(yaml.load(sys.stdin),sys.stdout, indent=4)' < tftpboot/varMatrix.yaml > tftpboot/varMatrix.json
