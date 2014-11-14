#installing apache
#set -e

sudo apt-get update
sudo apt-get install apache2
xdg-open http://localhost  #for checking if apache is installed
read -p "Is apache working (y or n)" answer
if [ $answer = "n" ] ; then
	echo "Something went wrong!"
	echo "please try again"
	exit 0
fi
echo " Apache is installed"
# installing apache and checking finished

#installing mysql
clear
echo "mysql installation is starting"
echo "follow the instructions on the screen for complete installation of mysql"
echo
echo "When it asks for password type \"password\" only"
echo 
echo "press enter to continue"
read 
sudo apt-get install mysql-server php5-mysql
sudo mysql_install_db  #for creating database directory structure where it will store its information
echo "mysql installation is complete press enter to continue"
read
#mysql installation complete

#php installation
sudo apt-get install php5 libapache2-mod-php5 php5-mcrypt
sudo sed -i 's/index.html/index.php/g' /etc/apache2/mods-enabled/dir.conf # for replacing the index.php with index.html
#sudo sed -i 's/index.php/index.html/g' /etc/apache2/mods-enabled/dir.conf  # for replacing the index.php with index.html
sudo service apache2 restart
echo "php installation is complete press enter to continue"
read
 # php installation complete
 
 sudo apt-cache search php5-
 sudo apt-cache show php5-cli
 sudo apt-get install php5-cli
 echo "place your documents '/var/www/html/' for correct execution"
  
  # lamp installation complete
 
 #mysql for wordpress setup
 echo "enter the name for wordpress database"
 read wp_dbname
 echo "enter the username for mysql user account"
 read wp_username
 echo "enter the password for the username"
 read wp_userpass
 mysql --user="root" --password="password"  --execute="CREATE DATABASE IF NOT EXISTS $wp_dbname; GRANT USAGE ON *.* TO '$wp_username'@'localhost'; DROP USER '$wp_username'@'localhost'; CREATE USER $wp_username@localhost IDENTIFIED BY '$wp_userpass'; GRANT ALL PRIVILEGES ON $wp_dbname.* TO $wp_username@localhost; FLUSH PRIVILEGES; "
 echo "mysql database for wordpress has completed"
 echo "press enter to continue"
 #mysql setup finished

 #wordpress download
 clear
 echo "downloading wordpress....."
 cd ~
wget http://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz
sudo apt-get update
sudo apt-get install php5-gd libssh2-php
clear
echo "configuring wordpress"
cd ~/wordpress
cp wp-config-sample.php wp-config.php
sed -i 's/database_name_here/$wp_dbname/g' wp-config.php  
sed -i 's/username_here/$wp_username/g' wp-config.php 
sed -i 's/password_here/$wp_userpass/g' wp-config.php 
sudo rsync -avP ~/wordpress/ /var/www/html/
cd /var/www/html
sudo chown -R root *
DIRECTORY=/var/www/html/wp-content/uploads
if [ -d "$DIRECTORY" ]; then
  # Control will enter here if $DIRECTORY exists.
    continue
else
    sudo mkdir /var/www/html/wp-content/uploads
fi
sudo chown -R :www-data /var/www/html/wp-content/uploads
echo "wordpress installation complete"
echo "press enter to continue"
read
xdg-open http://localhost 
