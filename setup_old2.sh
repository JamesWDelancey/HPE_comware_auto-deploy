#apt-get -y update
#apt-get -y upgrade
#apt-get -y install isc-dhcp-server
#apt-get install xinetd tftpd tftp
#echo 'service tftp' > /etc/xinetd.d/tftp
#echo '{' >> /etc/xinetd.d/tftp
#echo 'protocol = udp' >> /etc/xinetd.d/tftp
#echo 'port = 69' >> /etc/xinetd.d/tftp
#echo 'socket_type = dgram' >> /etc/xinetd.d/tftp
#echo 'wait = yes' >> /etc/xinetd.d/tftp
#echo 'server = /usr/sbin/in.tftpd' >> /etc/xinetd.d/tftp
#echo 'server_args = /tftpboot' >> /etc/xinetd.d/tftp
#echo 'disable = no' >> /etc/xinetd.d/tftp
#echo 'user = nobody' >> /etc/xinetd.d/tftp
#echo '}' >> /etc/xinetd.d/tftp
#mkdir /tftpboot
chmod -R 777 /tftpboot
chown -R nobody /tftpboot
#service xinetd restart

#apt-get install vsftpd
#cp /etc/vsftpd.conf /etc/vsftpd.conf.bak
#sed -i 's/#write_enable=YES/write_enable=YES/' /etc/vsftpd.conf
#sed -i 's/#local_umask/local_umask/' /etc/vsftpd.conf
#sed -i 's/#chroot_local_user/chroot_local_user/' /etc/vsftpd.conf
#sed 's///g' /etc/vsftpd.conf
#sed 's///g' /etc/vsftpd.conf
#sed 's///g' /etc/vsftpd.conf
#sed 's///g' /etc/vsftpd.conf
#echo 'allow_writeable_chroot=YES' >> /etc/vsftpd.conf
#echo 'pasv_enable=YES' >> /etc/vsftpd.conf
#echo 'pasv_min_port=40000' >> /etc/vsftpd.conf
#echo 'pasv_max_port=40100' >> /etc/vsftpd.conf
#service vsftpd restart

#apt-get -y install python-virtualenv
#cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.bak
#virtualenv --no-site-packages comware
#cd comware
#source bin/activate
#deactivate
echo 'ddns-update-style none;' > /etc/dhcp/dhcpd.conf
echo 'authoritative;' > /etc/dhcp/dhcpd.conf
echo 'subnet 10.1.1.0 netmask 255.255.255.0 {' >> /etc/dhcp/dhcpd.conf
echo '    range 10.1.1.100 10.1.1.200;' >> /etc/dhcp/dhcpd.conf
echo '    option tftp-server-name "10.1.1.5";' >> /etc/dhcp/dhcpd.conf
echo '    option bootfile-name "2c:23:3a:5b:74:52_boot.py";' >> /etc/dhcp/dhcpd.conf
echo '    option broadcast-address 10.1.1.255;}' >> /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart

netstat -anpu
netstat -anpt
#apt-get -y install git
cd comware/
source bin/activate
echo $PATH
#pip install jinja2
#pip install pyyaml
#git clone https://github.com/Mierdin/jinja2-nxos-config boot
#git clone https://github.com/Mierdin/jinja2-nxos-config config
#cp boot/config.yaml boot/config_bak.yaml
#cp config/config.yaml config/config_bak.yaml
rm /tftpboot/*.cfg

##switch1
#echo 'host host1 {' >> /etc/dhcp/dhcpd.conf
#echo '    option broadcast-address 10.1.1.255;' >> /etc/dhcp/dhcpd.conf
#echo '    hardware ethernet 2c:23:3a:5b:74:52;' >> /etc/dhcp/dhcpd.conf
#echo '    fixed-address 10.1.1.11;' >> /etc/dhcp/dhcpd.conf
#echo '    option tftp-server-name "10.1.1.5";' >> /etc/dhcp/dhcpd.conf
#echo '    option bootfile-name "2c:23:3a:5b:74:52_boot.py";}' >> /etc/dhcp/dhcpd.conf
#service isc-dhcp-server restart

cd boot/
cp -f config_bak.yaml config.yaml
sed -i 's/var_hostname/RSC-ALPHA-254-256/' config.yaml
sed -i 's/var_irf/1/' config.yaml
sed -i 's/var_config_file/2c:23:3a:5b:74:52_config.cfg/' config.yaml
python main.py config.yaml > /tftpboot/2c:23:3a:5b:74:52_boot.py
#cat /tftpboot/2c:23:3a:5b:74:52_boot.cfg
cd ../config/
cp -f config_bak.yaml config.yaml
sed -i 's/var_hostname/RSC-ALPHA-254-256/' config.yaml
python main.py config.yaml > /tftpboot/2c:23:3a:5b:74:52_config.cfg
#cat /tftpboot/2c:23:3a:5b:74:52_config.cfg
#end switch


chmod 777 -R /tftpboot/*
