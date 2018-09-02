#!/bin/sh
current_php_version=$(php -v | grep -o 'PHP [0-9].[0-9]' | grep -o '[^PHP ]*')

echo "* Your PHP version is: $current_php_version"

read -p "Enter needed PHP version [7.0]: " php_version

if [ -z "$php_version" ]; then
  php_version="7.0"
fi

echo "* Disabling Apache PHP $current_php_version module..."
sudo a2dismod php$current_php_version > /dev/null

echo "* Enabling Apache PHP $php_version module..."
sudo a2enmod php$php_version > /dev/null

echo "* Restarting Apache..."
sudo service apache2 restart > /dev/null

echo "* Switching CLI PHP to $php_version..."
sudo update-alternatives --set php /usr/bin/php$php_version > /dev/null

echo "* Switched to PHP $php_version"