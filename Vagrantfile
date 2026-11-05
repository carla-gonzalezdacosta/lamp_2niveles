
Vagrant.configure("2") do |config|

  config.vm.box = "debian/bookworm64"

  # PRIMERA MÁQUINA: APACHE
  config.vm.define "apache" do |apache|

    apache.vm.hostname = "CarlaGonzalezApache"

    # NAT: acceso a Internet
    apache.vm.network "forwarded_port",
      guest: 80,
      host: 8080,
      host_ip: "127.0.0.1"

    # Red privada: comunicación con MySQL
    apache.vm.network "private_network", ip: "192.168.56.10"

    apache.vm.provider "virtualbox" do |vb|
      vb.name = "CarlaGonzalezApache"
      vb.memory = 2048
      vb.cpus = 2
    end

    # Aprovisionamiento Apache
    apache.vm.provision "shell", path: "scripts/configurar_apache.sh"

  end

  # SEGUNDA MÁQUINA: MYSQL
  config.vm.define "mysql" do |mysql|

    mysql.vm.hostname = "CarlaGonzalezMariadb"

    # Red privada: comunicación con Apache
    mysql.vm.network "private_network", ip: "192.168.56.11"

    mysql.vm.provider "virtualbox" do |vb|
      vb.name = "CarlaGonzalezMariaDB"
      vb.memory = 2048
      vb.cpus = 2
    end

    # Aprovisionamiento mariadb
    mysql.vm.provision "shell", path: "scripts/configurar_mysql.sh"

  end

end
