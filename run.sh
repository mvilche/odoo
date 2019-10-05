#!/bin/sh
set -e

if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
cat /usr/share/zoneinfo/$TIMEZONE >> /etc/localtime && \
echo $TIMEZONE >> /etc/timezone
fi


ID=$(id -u)
echo "openshift:x:$ID:$ID:Openshift user,,,:/opt/odoo:/bin/bash" >> /etc/passwd
echo "INICIANDO ODOO...."

sleep 2s
exec /opt/odoo/odoo-bin "$@"
