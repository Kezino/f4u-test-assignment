FROM php:7.1-fmp

# Dev tools
RUN apt-get update && apt-get install -y mc nano git vim bash-completion telnet libssl-dev && rm -r /var/lib/apt/lists/*

###############################
# PHP
###############################

# Extensions
RUN docker-php-ext-install mbstring bcmath pcntl opcache calendar dba exif gettext mysqli sockets pdo_mysql shmop sysvmsg

# Common extension dependencies
RUN apt-get update && apt-get install -y php-amqplib libssl-dev libc-client2007e-dev libkrb5-dev \
    && rm -r /var/lib/apt/lists/*

# imap
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos && docker-php-ext-install imap

# zip
RUN apt-get update && apt-get install -y zlib1g-dev \
    && docker-php-ext-install zip \
    && rm -r /var/lib/apt/lists/*

# bz2
RUN apt-get update && apt-get install -y libbz2-dev \
    && docker-php-ext-install bz2 \
    && rm -r /var/lib/apt/lists/*

# intl
RUN apt-get update && apt-get install -y libicu-dev \
    && docker-php-ext-install intl \
    && rm -r /var/lib/apt/lists/*

# apcu
RUN pecl install apcu && echo "extension=apcu.so" > $PHP_INI_DIR/conf.d/apcu.ini

# gd
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
    && docker-php-ext-install gd \
    && rm -r /var/lib/apt/lists/*

COPY conf/php.ini /usr/local/etc/php/

# Node
ARG NODE_SRC
RUN curl -sL $NODE_SRC | bash - \
    && apt-get update \
    && apt-get install -y nodejs \
    && rm -r /var/lib/apt/lists/*

# gosu
RUN gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4
RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.5/gosu-$(dpkg --print-architecture)" \
   && curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/1.5/gosu-$(dpkg --print-architecture).asc" \
   && gpg --verify /usr/local/bin/gosu.asc \
   && rm /usr/local/bin/gosu.asc \
   && chmod +x /usr/local/bin/gosu

# Process managers
RUN apt-get update && apt-get install -y cron supervisor && rm -r /var/lib/apt/lists/*

COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Composer
ARG COMPOSER_VERSION
RUN curl -o ./composer-setup.php https://getcomposer.org/installer \
    && php composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=$COMPOSER_VERSION \
    && rm -rf composer-setup.php

# PHP-CS-Fixer
RUN cd /usr/local/bin \
    && curl http://get.sensiolabs.org/php-cs-fixer.phar -o php-cs-fixer \
    && chmod a+x php-cs-fixer

# Add system group/user
RUN groupadd -r symfony && useradd -r -g symfony -s /bin/bash -m symfony

ENV PATH "/var/www/f4u-test/bin:$PATH"
RUN echo "export PATH=$PATH" >> /home/symfony/.bashrc

WORKDIR /var/www/f4u-test

COPY entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
