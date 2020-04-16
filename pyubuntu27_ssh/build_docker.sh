#!/bin/bash

echo "*** Configurando sistema ***"

echo "--- Creando imagen ---"

docker build -t wiki_host .

echo "--- Registrando Alias wiki_main y wiki_db ---"

echo "127.0.0.1 wiki_main wiki_db" | sudo tee -a /etc/hosts

echo "--- Creando contenedores ---"

echo "Creando contenedor wiki_main"

docker run -d -P --name wiki_main -p 2221:22 -p 80:80 wiki_host

echo "Creando contenedor wiki_db"

docker run -d -P --name wiki_db -p 2222:22 -p 3306:3306 wiki_host

echo "--- Cambiando los permisos a la llave privada ---"

chmod 0600 ../Keys/key

echo "--- Registrando contenedores en known_hosts de ssh ---"

echo "Registrando wiki_main"

ssh -o StrictHostKeyChecking=no root@wiki_main -p 2221 -i ../Keys/key hostname

echo "Registrando wiki_db"

ssh -o StrictHostKeyChecking=no root@wiki_db -p 2222 -i ../Keys/key hostname

echo "*** Contenedores listo ***"
