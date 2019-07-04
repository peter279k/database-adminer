# Install required packages
FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-get install -y python-software-properties
RUN LC_ALL=C.UTF-8 add-apt-repository -y ppa:ondrej/php
RUN apt-get update
RUN apt-get install -y apt-transport-https apt-utils curl php7.1-cli php7.1-mysql php7.1-curl
RUN apt-get install -y php7.1-xml php7.1-dom php7.1-xsl php7.1-json php7.1-odbc php7.1-dev php7.1-fpm nginx

RUN apt-get update && apt-get install -y locales wget
RUN locale-gen "en_US.UTF-8"
RUN echo 'LC_ALL="en_US.UTF-8"' > /etc/default/locale

RUN wget https://github.com/vrana/adminer/releases/download/v4.7.1/adminer-4.7.1.php
RUN mv adminer-4.7.1.php /var/www/html/index.php

WORKDIR /root/dbp-dataexchange
COPY ./nginx-default.conf /etc/nginx/sites-available/default
COPY ./*.php ./
COPY ./.htpasswd /etc/nginx

EXPOSE 5000
CMD ["bash", "-c", "service php7.1-fpm start && nginx -g 'daemon off;'"]
