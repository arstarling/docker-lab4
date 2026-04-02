FROM debian:stable

RUN echo "deb http://ftp.fi.debian.org/debian stable main non-free" > /etc/apt/sources.list.d/docker-lab4.list

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nginx && \
    apt-get clean

RUN rm -rf /var/www/*

RUN mkdir -p /var/www/company.com/img

COPY index.html /var/www/company.com/
COPY img.jpg /var/www/company.com/img/

RUN chmod -R 754 /var/www/company.com

RUN groupadd Skvortsova && \
    useradd Arina && \
    usermod -aG Skvortsova Arina

RUN chown -R Arina:Skvortsova /var/www/company.com

RUN sed -i 's#/var/www/html#/var/www/company.com#g' /etc/nginx/sites-enabled/default

RUN sed -i 's/user www-data;/user Arina;/g' /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
