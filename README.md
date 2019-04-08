# Odoo source Docker images

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


# Funcionalidades:

  - Permite definir la zona horaria al iniciar el servicio
  - Permite definir parametros de JAVA al iniciar el servicio
  - Permite definir el id del usuario que iniciará el contenedor
  - El jboss se descarga al iniciar el servicio por primera vez, si ya fue descargado se omite este paso.
  - Non-root
  - Openshift compatible

### Iniciar


Ejecutar para iniciar el servicio

```sh
docker run -d --name jboss7.1.1 -e TIMEZONE=America/Montevideo -v $PWD/jboss:/opt/jboss -e USERID=1000 sofislab/jboss:as7.1.1-jdk7-alpine3.8

```

### Variables


| Variable | Detalle |
| ------ | ------ |
| TIMEZONE | Define la zona horaria a utilizar (America/Montevideo, America/El_salvador) |
| GROUP_ID | Define id del grupo que iniciará el servicio (Ej: 1001) |
| USER_ID | Define id del grupo que iniciará el servicio (Ej: 1002) |
| POSTGRES_HOST | Ip o nombre del servidor postgres |
| POSTGRES_USER | Usuario servidor postgres |
| POSTGRES_PASSWORD | Contraseña servidor postgres |
| POSTGRES_PORT | Puerto servidor postgres |
| CUSTOM_REPO  | Repositorio git adicional (El mismo se descargará en el directorio custom_addons) |
| PULL_NEW_CHANGES | Realiza un pull al repositorio oficial de odoo previo al inciiar (true or false) |
| CHECK_REQUIREMENTS | Ejecuta requirements.txt previo al iniciar (true or false) |

License
----

Martin vilche


