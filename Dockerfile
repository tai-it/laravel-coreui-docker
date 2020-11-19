FROM php:7.4-fpm

RUN apt-get update &&\
    apt-get install apt-utils curl gnupg apt-transport-https ca-certificates -y &&\
    curl -sL https://deb.nodesource.com/setup_14.x | bash - &&\
    mkdir -p /usr/share/man/man1 &&\
    apt-get install nodejs python g++ git make unzip zip libmcrypt-dev libcurl4-openssl-dev libc-client-dev libkrb5-dev p7zip-full vim zlib1g-dev libpng-dev -y &&\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
    apt update && apt install yarn &&\
    docker-php-ext-install -j$(nproc) gd &&\
    docker-php-ext-install pdo_mysql bcmath curl opcache mysqli

WORKDIR /var/www/bizcard
COPY . /var/www/bizcard