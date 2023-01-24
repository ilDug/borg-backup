apt update

apt install -y \
    ssmtp \
    mailutils \
    borgbackup \
    cifs-utils


read -p "CIFS username: " CIFS_USER 
read -p "CIFS password: " CIFS_PW 

echo "\
username=$CIFS_USER
password=$CIFS_PW" > ./configs/credentials

read -p "email: " EMAIL 
read -p "domain: " EMAIL_DOMAIN 
read -p "password: " EMAIL_PASSWORD 


echo "\
root=$EMAIL
mailhub=mail.$EMAIL_DOMAIN:587
hostname=$EMAIL_DOMAIN
FromLineOverride=YES
UseTLS=YES
UseSTARTTLS=YES
AuthMethod=LOGIN
AuthUser=$EMAIL
AuthPass=$EMAIL_PASSWORD" > /etc/ssmtp/ssmtp.conf