## Run everything as sudo
##git clone https://github.com/delancj/HPE_comware_auto-deploy.git comware
#chmod 777 ./setup.sh
#apt-get update
#apt-get -y upgrade
#apt-get -y install git
#git config --global user.name "James Delancey"
#git config --global user.email "jamesdelanceyjr@gmail.com"
##git push --set-upstream https://github.com/delancj/HPE_comware_auto-deploy.git
##git pull

git clone https://github.com/Mierdin/jinja2-nxos-config.git config
#apt-get -y install isc-dhcp-server
#cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd_bak.conf
echo 'default-lease-time 3600;' > /etc/dhcp/dhcpd.conf
echo 'authoritative;' >> /etc/dhcp/dhcpd.conf
echo 'max-lease-time 3600;' >> /etc/dhcp/dhcpd.conf
echo 'ddns-update-style none;' >> /etc/dhcp/dhcpd.conf
echo 'subnet 10.1.1.0 netmask 255.255.255.0 {' >> /etc/dhcp/dhcpd.conf
echo '    range 10.1.1.10 10.1.1.250;' >> /etc/dhcp/dhcpd.conf
echo '}' >> /etc/dhcp/dhcpd.conf
service isc-dhcp-server restart
netstat -plnut4
#echo 'source-directory /etc/network/interfaces.d' > /etc/network/interfaces
#echo 'auto lo' >> /etc/network/interfaces
#echo 'iface lo inet loopback' >> /etc/network/interfaces
#echo 'auto enxb827ebfb8e94' >> /etc/network/interfaces
#echo 'iface enxb827ebfb8e94 inet static' >> /etc/network/interfaces
#echo '    address 10.1.1.1' >> /etc/network/interfaces
#echo '    netmask 255.255.255.0' >> /etc/network/interfaces
#ifdown enxb827ebfb8e94 && ifup enxb827ebfb8e94
#ifconfig | grep addr



