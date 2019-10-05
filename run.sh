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
echo "INICIANDO ODOO...."
sleep 2s



if [ `id -u` -ge 10000 ]; then
cat /etc/passwd | sed -e "s/^openshift:/builder:/" &gt; /tmp/passwd
echo "openshift:x:`id -u`:`id -g`:,,,:/opt/odoo:/bin/bash" &gt;&gt; /tmp/passwd
cat /tmp/passwd &gt; /etc/passwd
rm /tmp/passwd
fi


exec /opt/odoo/odoo-bin "$@"
