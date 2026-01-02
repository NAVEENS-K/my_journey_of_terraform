#!/bin/bash
apt install -y nginx

cd /var/www/

chmod 755 html

cd html

rm -rf *

git clone https://github.com/NAVEENS-K/static_site_for_learning_aws.git

mv static_site_for_learning_aws/* .
rm -rf static_site_for_learning_aws/

systemctl restart nginx

apt update -y

apt install nodejs npm -y

npm install express aws-sdk -y

cd backend

npm init -y
npm install


cp /var/www/html/nginx/default.conf /etc/nginx/sites-enabled/default

systemctl reload nginx

node server.js
