FROM php:7.4-fpm

RUN apt-get update &&\
    apt-get install apt-utils curl gnupg -y &&\
    curl -sL https://deb.nodesource.com/setup_14.x | bash - &&\
    mkdir -p /usr/share/man/man1 &&\
    apt-get install nodejs python g++ git yarn make unzip zip libmcrypt-dev libcurl4-openssl-dev libc-client-dev libkrb5-dev p7zip-full vim zlib1g-dev libpng-dev -y &&\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
    docker-php-ext-install -j$(nproc) gd &&\
    docker-php-ext-install pdo_mysql bcmath curl opcache mysqli

RUN apt-get install -y apt-transport-https ca-certificates
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update && apt install yarn

WORKDIR /var/www/bizcard
COPY . /var/www/bizcard