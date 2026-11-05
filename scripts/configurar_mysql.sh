#!/bin/bash
set -e

# Cargar variables del archivo .env
source /vagrant/.env

# Evitar preguntas durante la instalación
export DEBIAN_FRONTEND=noninteractive

# 1. Actualizar repositorios
sudo apt update

# 2. Instalar MariaDB
sudo apt install -y mariadb-server

# 3. Configurar conexiones remotas
sudo sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# 4. Reiniciar MariaDB
sudo systemctl enable mariadb
sudo systemctl restart mariadb

# 5. Crear base de datos y usuario
sudo mariadb -e "
CREATE DATABASE IF NOT EXISTS ${DB_NAME};

CREATE USER IF NOT EXISTS '${DB_USER}'@'${IP_MAQUINA_CLIENTE}'
IDENTIFIED BY '${DB_PASS}';

GRANT ALL PRIVILEGES ON ${DB_NAME}.*
TO '${DB_USER}'@'${IP_MAQUINA_CLIENTE}';

FLUSH PRIVILEGES;
"

# 6. Comprobar el servicio
sudo systemctl status mariadb --no-pager
