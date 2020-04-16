FROM ubuntu:16.04

#*********************** Configurando sistema
# - Actualizando repositorios
# - Instalando postgres
# - Anexando codificacion en_US.UTF-8 al sistema

RUN apt update -y && apt install postgresql postgresql-contrib -y && \
    locale-gen en_US.UTF-8

#************************ Configurando postgres
# - Cambiando usuario
# - Iniciando servicio
# - Creando usuario moodle en postgres
# - Generando base de datos
# - Habilitando puerto 5432
# - Estableciendo comando a ejecutar cuando se inicie el contenedor

SHELL ["su","postgres","-c"]
RUN service postgresql start && \
     sleep 30 && \
     echo "CREATE USER moodleuser WITH PASSWORD 'moodle'" | psql && \
     sleep 30 && \
     echo "CREATE DATABASE moodle WITH OWNER moodleuser ENCODING 'UTF8' LC_COLLATE='en_US.UTF-8' LC_CTYPE='en_US.UTF-8' TEMPLATE=template0" | psql

# - Anexando configuraciones para habilitar conexiones externas - referencia http://www.evaristogz.com/instalacion-postgresql-acceso-remoto-externo/#acceso-remoto

ADD config/postgresql.conf /etc/postgresql/9.5/main/
ADD config/pg_hba.conf /etc/postgresql/9.5/main/

EXPOSE 5432
CMD ["su","postgres","-c","/usr/lib/postgresql/9.5/bin/postgres -D /var/lib/postgresql/9.5/main -c config_file=/etc/postgresql/9.5/main/postgresql.conf"]
