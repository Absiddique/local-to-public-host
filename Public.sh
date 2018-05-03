#!/bin/bash

# Ensure we are being ran as root
if [ $(id -u) -ne 0 ]; then
	echo "This script must be ran as root"
	exit 1
fi

if [ $(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c "ok installed") -eq 0 ];

then

  apt-get install apache2;

fi

echo "<!DOCTYPE HTML>
<html>
  <head>
    <title>Hello World! Site Title</title>
  </head>
  <body>
    <h1>Hello World!</h1>
  </body>
</html> " > index.html

mv index.html /var/www/html/index.html

service apache2 start

./ngrok http 80
