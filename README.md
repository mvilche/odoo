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
docker run -d --name odoo11 -P 8070:8070 -e POSTGRES_HOST=postgres -e POSTGRES_PASSWORD=12345 -e POSTGRES_USER=odoo -e POSTGRES_PORT=5432 -e TIMEZONE=America/Montevideo -e USER_ID=1000 -e GROUP_ID=1000 -v $PWD/odoo:/opt/app/odoo mvilche/odoo:11-alpine3.9

```

### Persistencia de datos


| Directorio | Detalle |
| ------ | ------ |
| /opt/app/odoo | Directorio raiz |


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



