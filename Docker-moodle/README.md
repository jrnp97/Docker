# Creacion de imagen moodle para Docker - ubuntu:16.04 #

## Dependencias ##

* Apache
* PHP
* mysql o postgresql (Utilización de contenedor mysql)

## Instalando Apache ##

**Requerimientos**

+ Minimo 50MB de espacio libre en el disco duro o medio de alamcenamiento (Despues de la instalación se consumen 10MB).

+ Tener instalado el compilador [ANSI-C](https://www.gnu.org/software/gcc/index.html) >= 2.7.2 `apt install gcc make`

+ Tener instaladas herramientas basadas en el protocolo NTP para el monitoreo de el tiempo como *ntpdate* o *nxdtp*, ya que algunos elementos del protocolo HTTP utilizan dichas herramientas.

* Tener instalado [Perl 5](http://desarrollandowebsdinamicas.blogspot.com.co/2012/11/instalar-perl-en-ubuntu-desde-la-linea.html) >= 5.003, ya que es usado por alguno scripts como *apxs* o *dbmmanage*(Opcional) `apt install perl` (Opcional)


**Pasos (con codigo fuente)**

* Descarga:
Se puede seleccionar el recurso desde [aquí](http://httpd.apache.org/download.cgi), un ejemplo puede ser

```
$ curl -sSF http://apache.uniminuto.edu//httpd/httpd-2.2.34.tar.gz
$ wget http://apache.uniminuto.edu//httpd/httpd-2.2.34.tar.gz
```

* Extracción:
Despues de tener el recurso se procede a extraer su contenido ya sea de las siguientes 2 formas dependiendo de la extensión

```
$ gzip -d httpd-2_0_NN.tar.gz
$ tar xvf httpd-2_0_NN.tar
```

* Configuración:

Existen distintos argumentos que se pueden extablecer al momento de realizar la configuración de Apache pueden observar [aquí](http://httpd.apache.org/docs/2.0/programs/configure.html), pero como primordial se debe establecer el argumento **--prefix=BASE_DIR**, el cual es equivalente al directorio donde se almacenara Apache, algunos ejemplos pueden ser

```
$ ./configure --prefix=/usr/local/apache2 (directorio por defecto)
$ ./configure --prefix=/sw/pkg/apache
```
*Nota -> cabe aclarar que este comando se tiene que ejecutar posicionado en la carpeta que contiene los recursos extraidos en pasos anteriores, o tenerla instanciada (referenciada path/configure) *

* Construcción:

Uno de los ultimos pasos es la "construccion" la cual instalara paquetes que se encuentran por defecto con Apache y más, el comando utilizado es

```
$ make install
```

* Personalización:

Por ultimo se puede realizar la configuración de Apache editando su archivo de configuración, del que se puede encontrar referencia [aquí](http://httpd.apache.org/docs/2.0/configuring.html), se puede editar con su editor favorito y se encuentra en el directorio PREFIX/conf/httpd.conf, ejemplo
```
$ vim PREFIX/conf/httpd.conf
$ nano PREFIX/conf/httpd.conf
$ gedit PREFIX/conf/httpd.conf
```

* Inicio:
Se puede ejecutar Apache de la siguiente forma

```
$ PREFIX/bin/apachectl start (ejecutarlo)
$ PREFIX/bin/apachectl stop (detenerlo)
```

**RESUMEN**
```

Descarga -> $ wget http://apache.uniminuto.edu//httpd/httpd-2.2.34.tar.gz
Extracción -> $ gzip -d httpd-2_0_NN.tar.gz
		tar xvf httpd-2_0_NN.tar
Configuración -> $ ./configure --prefix=PREFIX
Compilacion y instalación -> $ make && make install
Personalizacion -> $ vi PREFIX/conf/httpd.conf
Prueba -> $ PREFIX/bin/apachectl start

```

**pasos (desde el manejador de paquetes apt)**

`$ apt install apache2`

***Referencias -> http://httpd.apache.org/docs/2.0/install.html***


## Instalando PHP 7.0 ##

### Extensiones requeridas ###

+ iconv - Instalada y activada  por defecto [+]
+ mbstring - $ apt install php-mbstring [+]
+ curl - $ apt install php-curl [+]
+ openssl - $ apt install openssl (Configuracion requerida) [+]
+ tokenizer - Instalada y activada por defecto en php > 4.3.0 (integrada en php7.0-common) [+]
+ xmlrpc - $ apt install php-xmlrpc (Configuracion) [-]
+ soap - $ apt install php-soap [-]
+ ctype - $ apt install php-ctype (integrada en php7.0-common) [+]
- zip - $ apt install php-zip o '--enable-zip' [-]
+ gd - $ apt install php-gd [+]
+ simplexml (Integrada en php7.0-xml) o '--enable-simplexml' para php < 5.1.2 [+]
+ spl - Disponible y compilada desde php >= 5.0.0 [+]
+ pcre - Integrada por defecto [+]
	+ Vease los reportes de vulnerabilidades
		- CVE-2015-2325
		- CVE-2015-2326
		- CVE-2015-8383
		- CVE-2015-8386
		- CVE-2015-8387
		- CVE-2015-8389
		- CVE-2015-8390
		- CVE-2015-8391
		- CVE-2015-8393
		- CVE-2015-8394

+ dom - Habilitada de forma predeterminada (Integrada en php7.0-xml) [+]
+ xml - Habilitada de forma predeterminada ($ apt install php-xml) [+]
+ intl - Habilitada de forma predeterminada en php >= 5.3.0 ($ apt install php-intl o '--enable-intl') [-]
+ json - Habilitada de forma predeterminada en php >= 5.2.0 ($ apt install php-json ) [+]
+ mysqli - Habilitada de forma predeterminada [+]


### Configuraciones ###

+ register_globals = Off
+ memory_limit = 128M (recommended. Large systems may need an even higher setting)
+ session.save_handler = Files
+ file_uploads = On
+ session.auto_start = 0
+ Configurar directorio temporal usado por el servidor web.
+ Configurar la seccion de inicio/sesion, para que el servidor lo use.
+ post_max_size and upload_max_filesize hasta el maximo tamaño que decida usarlo
+ Configurar la parte del email y la conexion a la base de datos a la ajustada en su entorno.

***Referencias -> https://docs.moodle.org/23/en/PHP***

## Instalando Moodle ##

**Requerimientos**

+ 160MB minimos libres de espacio en disco.
+ 256MB minimos de memoria RAM 1GB o más es recomendada.


**Pasos**

* Descarga de moodle:

Se cuentan con 2 opciones descargar el recurso comprimido [aquí](https://download.moodle.org/releases/latest/) o clonar directamente moodle de github [aquí](https://github.com/moodle/moodle), entonces se podrían ejecutar

```
$ wget https://download.moodle.org/download.php/direct/stable33/moodle-latest-33.tgz
$ git clone -b MOODLE_23_STABLE git://git.moodle.org/moodle.git
```

* Cambiar los permisos:

Se requiere cambiar los permisos de la carpeta descargada, si en su defecto ha optado por descargar el archivo comprimido, antes de realizar este paso se requiere de su descomprensión, se ejecutan los siguiente comandos

```
El simbolo # quiere decir que la terminal se ejecuta en modo superusuario o administrador.

# chown -R root /path/to/moodle
# chmod -R 0755 /path/to/moodle

```

Como dicen en negrilla en la documentación, cabe resaltarlo aquí **Don't skip this step. Your site is vulnerable to hackers if you do. (No omitas este paso. Serás vulnerable a hackers si lo haces)**


* Instalación:
Procedemos a establecer un propietario temporalmente al directorio *moodle* creado, para que pueda escribir en el archivo config.php del servidor apache, de la siguiente forma

```
# chown www-data /path/to/moodle
# mkdir /path/moodledata (Creando directorio que almacenara los archivos)
# chown -R root /path/to/moodle (Reestableciendo propietario del directorio)
```


## Instalacion de postgres ##




# Configuracion #

**Nota: se debe tener instalado docker y docker-compose :D**

```
# Clonacion del repositorio

$ git clone https://github.com/jrnp97/Docker-moodle

# Se acede a la carpeta via terminal

$ cd Docker-moodle

# Se descarga la imagen de ubuntu de la cual estan basado las imagenes creadas

$ (sudo) docker pull ubuntu:16.04

# Se crea la imagen de moodle

$ (sudo) docker build -t moodle .

# Se accede al directorio postgres que se encuentra en el interior del directorio Docker-moodle

$ cd postgres

# se crea la imagen de postgres

$ (sudo) docker build -t psql_moodle .

# inicia el docker-compose (no daemon), se debe estar posicionado en el directorio Docker-moodle

$ (sudo) docker-compose up

```

* Ingresar al navegador https://127.0.0.1/moodle

![alt-text](/img/true.png)
