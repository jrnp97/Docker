#Partiendo de la imagen ubuntu 16.04 la cual tendremos como base
FROM ubuntu:16.04

#******************************** PHP
# - Actualizando repositorios
# - Instalando PHP 7.0 y extensiones requeridas que no vienen por defecto
# - Añadiendo archivo de configuracion

RUN apt-get update -y &&\
    apt-get install php7.0 \
    php7.0-xmlrpc \
    php7.0-zip \
    php7.0-simplexml \
    php7.0-intl \
    php7.0-pgsql \
    php7.0-curl \
    php7.0-gd \
    php7.0-mbstring \
    php7.0-soap \
    libapache2-mod-php7.0 -y

ADD config/php.ini /etc/php/7.0/cli/

#******************************** Apache
# - Instalando dependencias gcc,make,wget(descarga),curl (prueba)
# - Instalando Apache

RUN apt install gcc make wget curl git -y && \
    apt install apache2 -y

#********************************* Moodle
# - Accediendo a carpeta opt
# - Clonando repositorio de moodle
# - Accediendo a carpeta moodle
# - Cambiando el brach en el repositorio a MOODLE_32_STABLE el cual contiene la version 32 estable de moodle
# - Copiando recursivamente la carpeta del repositorio al directorio /var/www/html para ser detectado por apache
# - Creando carpeta donde se almacenaran los archivos de moodle
# - Cambiando permisos a directorios para hacer efectiva la instalación
# - Estableciendo configuracion de moodle basica
# - Copiando archivo ejecutable para iniciar apache2 (no daemon)
# - Estableciento apertura del puerto 80
# - Estableciendo comando a ejecutar cuando inicie el contenedor

RUN cd /opt && git clone git://git.moodle.org/moodle.git && \
    cd moodle && git checkout MOODLE_32_STABLE

RUN cp -R /opt/moodle /var/www/html/ && \
    mkdir /var/moodledata && \
    chown -R www-data /var/moodledata && \
    chmod -R 777 /var/moodledata && \
    chmod -R 755 /var/www/html/moodle

ADD config/config.php /var/www/html/moodle

# Configurando variables para ejecucion de Apache2
ENV APACHE_RUN_USER     www-data
ENV APACHE_RUN_GROUP    www-data
ENV APACHE_LOG_DIR      /var/log/apache2
ENV APACHE_PID_FILE     /var/run/apache2.pid
ENV APACHE_RUN_DIR      /var/run/apache2
ENV APACHE_LOCK_DIR     /var/lock/apache2
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80
ENTRYPOINT ["apache2","-DFOREGROUND"]
