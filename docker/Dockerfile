FROM php:7.4-fpm

RUN apt-get update &&\
    apt-get install apt-utils curl gnupg apt-transport-https ca-certificates -y &&\
    curl -sL https://deb.nodesource.com/setup_14.x | bash - &&\
    mkdir -p /usr/shared &&\
    apt-get install nodejs python git make unzip zip libmcrypt-dev libcurl4-openssl-dev libc-client-dev libkrb5-dev p7zip-full vim zlib1g-dev libpng-dev -y &&\
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer &&\
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
    apt update && apt install yarn apache2 -y &&\
    docker-php-ext-install -j$(nproc) gd &&\
    docker-php-ext-install pdo_mysql bcmath curl opcache mysqli &&\
    cd /etc/apache2/mods-enabled &&\
    ln -s ../mods-available/rewrite.load ./ &&\
    ln -s /dev/stdout /var/log/apache2/access_atslp.log &&\
    ln -s /dev/stdout /var/log/apache2/access_crmlp.log &&\
    ln -s /dev/stdout /var/log/apache2/access_firstlp.log &&\
    ln -s /dev/stdout /var/log/apache2/access_top.log &&\
    ln -s /dev/stderr /var/log/apache2/error_atslp.log &&\
    ln -s /dev/stderr /var/log/apache2/error_crmlp.log &&\
    ln -s /dev/stderr /var/log/apache2/error_firstlp.log &&\
    ln -s /dev/stderr /var/log/apache2/error_top.log

COPY ./apache2.conf /etc/apache2/apache2.conf
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
COPY ./run.sh /usr/local/bin/run.sh

RUN echo '* * * * * www-data /usr/local/bin/php /var/www/localhost/htdocs/artisan schedule:run >> /dev/null 2>&1' >> /etc/crontab
RUN chmod 755 /usr/local/bin/run.sh

WORKDIR /var/www/bizcard

CMD ["/usr/local/bin/run.sh"]