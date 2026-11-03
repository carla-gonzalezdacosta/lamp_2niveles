# Tarea: Pila LAMP en dos niveles
## Carla González Da Costa
## IWEB - ASIR 2º 
### 03/11/2026.


## 1. Introducción

El objetivo de esta práctica es desplegar una infraestructura web de dos niveles utilizando Vagrant y máquinas virtuales con Debian 12.

La infraestructura estará formada por dos máquinas virtuales independientes:

- **Servidor Apache:** encargado de alojar la aplicación web desarrollada en PHP.
- **Servidor MySQL:** encargado de almacenar y gestionar los datos de la aplicación.

La aplicación utilizada será `iaw-practica-lamp`, que permite realizar operaciones de gestión de usuarios, como añadir, consultar, modificar y eliminar registros de una base de datos.

Ambos servidores se comunicarán mediante una red privada. Únicamente el servidor Apache tendrá acceso a Internet a través de NAT, mientras que el servidor MySQL permanecerá sin acceso a Internet.


## 2. Estructura de la infraestructura

La infraestructura está formada por dos máquinas virtuales:

| Máquina virtual | Hostname | Función |
| Apache | CarlaGonzalezApache | Servidor web y PHP |
| MySQL | CarlaGonzalezMysql | Servidor de base de datos |

La comunicación entre ambas máquinas se realizará mediante una red privada con las siguientes direcciones IP:

| Servidor | Dirección IP |
| Apache | 192.168.56.10 |
| MySQL | 192.168.56.11 |


## 3. 

## 6. Incidencias durante la configuración

### 6.1. Máquinas virtuales inaccesibles en VirtualBox

Al iniciar las máquinas virtuales con Vagrant, apareció un error porque VirtualBox tenía registradas tres máquinas como inaccesibles.

Después de investigar el problema, comprobé que las carpetas de esas máquinas se habían movido de `ASIR_2\ISO\VM` a `ASIR_2\ASO\VM`, pero VirtualBox seguía buscando los archivos en la ubicación anterior.

Para solucionarlo, quité las máquinas de la lista de VirtualBox, sin eliminar sus archivos, y las añadí de nuevo seleccionando sus archivos `.vbox` desde la nueva ubicación.

Finalmente, las máquinas volvieron a aparecer correctamente en VirtualBox.

### 6.2. Problema de conexión SSH en la máquina MySQL

Durante la configuración de la máquina virtual MySQL, Vagrant no conseguía establecer la conexión SSH y mostraba el error:

```text
Timed out while waiting for the machine to boot
```

Para localizar el problema, comprobé primero si el puerto SSH de la máquina estaba accesible desde Windows:

```powershell
Test-NetConnection 127.0.0.1 -Port 2200
```

Después, consulté el estado de la máquina virtual y la configuración de sus adaptadores de red mediante:

```powershell
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" showvminfo "CarlaGonzalezMysql" --machinereadable | Select-String "VMState|cableconnected|nic1|Forwarding"
```

Al revisar el resultado, comprobé que el adaptador NAT estaba desconectado (`cableconnected1="off"`).

Para solucionarlo, volví a conectar el adaptador mediante el siguiente comando:

```powershell
& "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe" controlvm "CarlaGonzalezMysql" setlinkstate1 on
```

Por último, reinicié la máquina virtual desde Vagrant:

```powershell
vagrant reload mysql
```

Tras realizar estos pasos, Vagrant consiguió establecer la conexión SSH y completar correctamente el arranque de la máquina virtual.

---

## 7. Scripts de aprovisionamiento

Para automatizar la instalación y configuración de los servicios se utilizarán scripts Bash independientes para cada máquina virtual.

La estructura prevista es:

```text
scripts/
├── configurar_mysql.sh
└── configurar_apache.sh
```

- `configurar_mysql.sh`: instalará y configurará el servidor de bases de datos.
- `configurar_apache.sh`: instalará y configurará Apache, PHP y los componentes necesarios para ejecutar la aplicación web.

Los scripts se ejecutarán automáticamente mediante el aprovisionamiento de Vagrant.

Esta sección se completará con el contenido definitivo de los scripts y la explicación de cada comando.

---

## 8. Despliegue de la aplicación web

La aplicación utilizada es `iaw-practica-lamp`, un sistema básico de gestión de usuarios desarrollado con PHP y MySQL.

Permite realizar las siguientes operaciones:

- Añadir usuarios.
- Consultar registros.
- Editar usuarios existentes.
- Eliminar registros.

El código utilizado está basado en el repositorio `crud-php-simple`, de GitHub.

Esta sección se completará después de realizar la instalación y configuración de la aplicación.

---

## 9. Comprobaciones y capturas de pantalla

Se incluirán capturas de pantalla que permitan comprobar el funcionamiento de la infraestructura:

- Estado de las máquinas virtuales en Vagrant.
- Servidor Apache en funcionamiento.
- Servidor de bases de datos en funcionamiento.
- Comunicación entre ambos servidores.
- Aplicación web funcionando desde el navegador.
- Operaciones de gestión de usuarios.

---

## 10. Screencast

Se incluirá una grabación de pantalla donde se muestre el funcionamiento de la aplicación desplegada, incluyendo las operaciones de creación, consulta, modificación y eliminación de usuarios.

---

## 11. Repositorio GitHub

El proyecto se publicará en un repositorio público de GitHub que contendrá el fichero `Vagrantfile`, los scripts de aprovisionamiento, este documento técnico y el screencast de la aplicación.

**URL del repositorio:** Pendiente de completar.
