#installing apache
set -e

 sudo  apt-get update
 sudo apt-get install apache2
# xdg-open http://localhost  #for checking if apache is installed
#read -p "Is apache working (y or n)" answer
#if [ $answer = "n" ] ; then
#	echo "Something went wrong!"
#	echo "please try again"
#	exit 0
#fi
tput bold;
echo " Apache is installed"
echo "press enter to continue"
tput sgr0;
read x
# installing apache and checking finished

#installing mysql
clear
tput bold;
echo "Mysql installation is starting"
echo "Follow the instructions on the screen for complete installation of mysql"
echo
echo "When it asks for password type \"password\" only"
echo 
echo "press enter to continue"
tput sgr0;
read x
sudo apt-get install mysql-server php5-mysql
sudo mysql_install_db  #for creating database directory structure where it will store its information
echo "mysql installation is complete press enter to continue"
read x
#mysql installation complete

#php installation
clear
tput bold;
echo "Press enter to install php"
tput sgr0;
read x
sudo  apt-get install php5 libapache2-mod-php5 php5-mcrypt
sudo sed -i 's/index.html/index.php/g' /etc/apache2/mods-enabled/dir.conf # for replacing the index.php with index.html
sudo sed -i 's/index.php/index.html/g' /etc/apache2/mods-enabled/dir.conf  # for replacing the index.php with index.html
sudo  service apache2 restart
tput bold;
echo "php installation is complete press enter to continue"
tput sgr0;
read x
 # php installation complete
 
sudo   apt-cache search php5-
sudo   apt-cache show php5-cli
sudo   apt-get install php5-cli
tput bold;
 echo "place your documents '/var/www/html/' for correct execution"
  tput sgr0;
  # lamp installation complete
 
 #mysql for wordpress setup
 tput bold;
 echo "enter the name for wordpress database"
 tput sgr0;
 read wp_dbname
 tput bold;
 echo "enter the username for mysql user account"
 tput sgr0;
 read wp_username
 tput bold;
 echo "enter the password for the username"
 tput sgr0;
 read wp_userpass
 mysql --user="root" --password="password"  --execute="CREATE DATABASE $wp_dbname; GRANT USAGE ON *.* TO $wp_username@localhost IDENTIFIED BY '$wp_userpass'; GRANT ALL PRIVILEGES ON $wp_dbname.* TO $wp_username@localhost; FLUSH PRIVILEGES; "
 tput bold;
 echo "mysql database for wordpress has completed"
 tput sgr0;
 tput bold;
 echo "press enter to continue"
 tput sgr0;
 #mysql setup finished
 
 #wordpress download
 clear
 tput bold;
 echo "downloading wordpress....."
 tput sgr0;
 cd ~
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz #extracting wordpress
 sudo  apt-get update
 sudo  apt-get install php5-gd libssh2-php
clear
tput bold;
echo "configuring wordpress"
tput sgr0;
cd ~/wordpress
cp wp-config-sample.php wp-config.php
sudo sed -i 's/'$wp_dbname'/database_name_here/g' wp-config.php  #replacing database name
sudo sed -i 's/'$wp_username'/username_here/g' wp-config.php 
sudo sed -i 's/'$wp_userpass'/password_here/g' wp-config.php 
sudo  rsync -avP ~/wordpress/ /var/www/html/
cd /var/www/html
sudo chown -R root *
sudo mkdir /var/www/html/wp-content/uploads
sudo  chown -R :www-data /var/www/html/wp-content/uploads
tput bold;
echo "wordpress installation complete"
echo "press enter to continue"
tput sgr0;
read x
xdg-open http://localhost/wp-admin 
