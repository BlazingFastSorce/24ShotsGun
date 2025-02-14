#!/bin/bash
IS_MANUAL="$1"
install_services()
{
clear
echo "Installing Services..." 
cd ~
wget -O panda_aio_24.sh https://raw.githubusercontent.com/reyluar03/pandaunite/main/panda_aio_24.sh && chmod +x panda_aio_24.sh && ./panda_aio_24.sh "$IS_MANUAL"
cd ~ 

rm -rf *.sh*

}

configuration_overwritten()
{
clear
echo "Finilizing..."
{   

rm -rf /etc/openvpn/login/config.sh
rm -rf /etc/hysteria/config.sh

cat <<EOM > /etc/openvpn/login/config.sh
HOST='185.62.188.4'
USER='matthewz1_database2024'
PASS='matthewz1_database2024'
DB='matthewz1_database2024'
EOM
cp /etc/openvpn/login/config.sh /etc/hysteria/config.sh

systemctl restart cron
systemctl restart openvpn@server.service
systemctl restart openvpn@server2.service
systemctl restart hysteria-server
}&>/dev/null
}

update_encryption()
{
clear
echo "Updating encryption..."
{   

sed -i "s|eugcar|firenet|g" /etc/authorization/pandavpnunite/connection.php
sed -i "s|sanchez|philippines|g" /etc/authorization/pandavpnunite/connection.php

#--- execute asap
/usr/bin/php /etc/authorization/pandavpnunite/connection.php
/bin/bash /etc/authorization/pandavpnunite/active.sh

}&>/dev/null
}

clear 
install_services
configuration_overwritten
update_encryption
echo "Completed!"
