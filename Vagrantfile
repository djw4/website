# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "michaelward82/trusty64-php7"
  config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt install -y unzip php-mbstring

    cd /var/www
    curl -L https://getgrav.org/download/core/grav-admin/latest -O
    sudo unzip -q latest
    sudo rsync -a --remove-source-files grav-admin/ html/
  SHELL
end
