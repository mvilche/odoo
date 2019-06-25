#!/bin/sh
set -e
ODOO_ROOT=/opt/app/odoo
ODOO_DATADIR=/opt/app/odoo/.init
CUSTOM_REPO_DIR=/opt/app/odoo/custom_addons
ADDONS_REPO_DIR=/opt/app/odoo/addons
ODOO_VERSION=8.0
ODOO_REPO=https://github.com/odoo/odoo.git

    if [ -z $USER_ID ]; then
    echo "***************************************************"
    echo "NO SE ENCUENTRA LA VARIABLE USER_ID - INICIANDO POR DEFECTO"
    echo "*******************************************************"
    USER_ID=1000
    echo "USER_ID: 1000"
    else
    echo "***************************************************"
    echo "VARIABLE USER_ID ENCONTRADA SETEANADO VALORES: $USER_ID"
    usermod -u $USER_ID odoo
    echo "*******************************************************"
    fi


     if [ -z $GROUP_ID ]; then
    echo "***************************************************"
    echo "NO SE ENCUENTRA LA VARIABLE GROUP_ID - INICIANDO POR DEFECTO"
    echo "******************************************************"
    GROUP_ID=1000
    echo "GROUP_ID: 1000"
    else
    echo "***************************************************"
    echo "VARIABLE GROUP_ID ENCONTRADA SETEANADO VALORES: $GROUP_ID"
    groupmod -g $GROUP_ID odoo
    echo "*******************************************************"
    fi



if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
echo "SETENADO TIMEZONE"
cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime && \
echo $TIMEZONE > /etc/timezone
fi



    if [ -z $POSTGRES_HOST ] || [ -z $POSTGRES_USER ] || [ -z $POSTGRES_PASSWORD ] || [ -z $POSTGRES_PORT ]; then
    echo "***************************************************"
    echo "SE DETECTARON VARIABLES REQUERIDAS NO SETEADAS, VERIFICAR POSTGRES_USER, POSTGRES_ PASSWORD, POSTGRES_HOST, POSTGRES_PORT"
    echo "*******************************************************"
    exit 1
    fi


if [ -d $ODOO_DATADIR ]; then
	echo "**********************************************"
    echo "ODOO YA FUE INICIALIZADO - SE ENCONTRARON DATOS"
    echo "**********************************************"
else

    echo "***************************************************"
    echo "ODOO NO SE HA INICIALIZADO"
    echo "EL TIEMPO DE LA DESCARGA E INSTALACION DE LAS DEPENDENCIAS SERA DE UNOS MINUTOS"
    echo "INICIALIZANDO..."
    echo "*******************************************************"
    cd /opt/app && git clone --depth=1 -b $ODOO_VERSION $ODOO_REPO && \
    pip install pillow -U
    cd /opt/app/odoo && pip install -r requirements.txt && mkdir /opt/app/odoo/.init /opt/app/odoo/custom_addons && \
    pip install pillow -U
cat << EOF > odoo.cfg
[options]
db_host=$POSTGRES_HOST
db_port=$POSTGRES_PORT
db_user=$POSTGRES_USER
db_password=$POSTGRES_PASSWORD
addons_path=/opt/app/odoo/addons,/opt/app/odoo/custom_addons
data_dir=/opt/app/odoo/share/Odoo
xmlrpc_port=8070
EOF
    echo "FIX PERMISOS.." && chown $USER_ID:$USER_ID -R /opt/app/odoo && cd /opt/app
    echo "*******************************************************" && \
	echo "ODOO $ODOO_VERSION INICIALIZADO CORRECTAMENTE" && \
    echo "*******************************************************"
	echo "TAREAS COMPLETADAS CORRECTAMENTE." && \
    echo "*******************************************************"
fi



if [ $CHECK_REQUIREMENTS == true  ]; then
    echo "**********************************************"
    echo "CHECK_REQUIREMENTS ACTIVADO - INSTALANDO DEPENDENCIAS"
    cd /opt/app/odoo && pip install -r requirements.txt
    echo "**********************************************"
fi


if [ $PULL_NEW_CHANGES == true  ]; then
    echo "**********************************************"
    echo "PULL_NEW_CHANGES ACTIVADO - HACIENDO PULL A " $ODOO_REPO
    cd /opt/app/odoo && git pull origin $ODOO_VERSION && cd - > /dev/null && \
    echo "PULL REALIZADO CORRECTO!"
    echo "**********************************************"
fi



if [ ! -z $CUSTOM_REPO ]; then
    echo "**********************************************"

    if [ -z $CUSTOM_REPO_BRANCH ]; then
    CUSTOM_REPO_BRANCH=master
    fi

    echo "CUSTOM_REPO ENCONTRADO - CLONANDO RAMA $CUSTOM_REPO_BRANCH EN $CUSTOM_REPO_DIR "
    mkdir /tmp/custom && cd /tmp/custom && git clone -b $CUSTOM_REPO_BRANCH $CUSTOM_REPO . && \
    cp -rf  * $CUSTOM_REPO_DIR/ && rm -rf /tmp/custom && cd - > /dev/null && \
    echo "CUSTOM_REPO INSTALADO CORRECTAMENTE!"
    echo "**********************************************"
fi


chown odoo:odoo -R /opt/app/odoo && echo "FIX PERMISSION OK"
echo "INICIANDO ODOO...."
sleep 2s
exec su-exec odoo /opt/app/odoo/odoo.py --without-demo=WITHOUT_DEMO "$@"
