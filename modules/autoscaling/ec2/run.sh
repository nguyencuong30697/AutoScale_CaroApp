#!/bin/bash
sudo su
yum update -y
yum install git -y
amazon-linux-extras install nginx1
systemctl start nginx.service
git clone https://github.com/nguyencuong30697/techmaster-homework.git
sed -i "1iInstance id:<b> `wget -q -O - http://169.254.169.254/latest/meta-data/instance-id`</b>" ./techmaster-homework/index.html
rm -rf /usr/share/nginx/html/*
cp techmaster-homework/* /usr/share/nginx/html/
systemctl restart nginx.service