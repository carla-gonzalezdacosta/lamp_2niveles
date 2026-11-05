#!/bin/bash
set -e

# Cargar variables del archivo .env
source /vagrant/.env

# Evitar preguntas durante la instalación
export DEBIAN_FRONTEND=noninteractive

# 1. Instalar Apache, PHP y Git
sudo apt update
sudo apt install -y apache2 php libapache2-mod-php php-mysql git

# 2. Descargar la aplicación
sudo rm -rf /var/www/html/*
sudo git clone https://github.com/josejuansanchez/iaw-practica-lamp /var/www/html

# 3. Configurar la conexión con MySQL
sudo tee /var/www/html/config.php > /dev/null <<EOF
<?php
define('DB_HOST', '$IP_SERVIDOR_MYSQL');
define('DB_NAME', '$DB_NAME');
define('DB_USER', '$DB_USER');
define('DB_PASSWORD', '$DB_PASS');

\$mysqli = mysqli_connect(DB_HOST, DB_USER, DB_PASSWORD, DB_NAME);
?>
EOF

# 4. Reiniciar Apache
sudo systemctl restart apache2

echo "Apache configurado correctamente"
