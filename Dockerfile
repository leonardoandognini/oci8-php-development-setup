FROM --platform=linux/amd64 php:8.2-fpm

RUN apt-get update && apt-get install -y \
    libpq-dev \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip libaio-dev --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN docker-php-ext-install intl

RUN docker-php-ext-install pdo pdo_pgsql mbstring exif pcntl bcmath gd

RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

ADD oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip /tmp/
ADD oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip /tmp/

RUN unzip /tmp/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /usr/local/ && \
    unzip /tmp/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /usr/local/

RUN ln -s /usr/local/instantclient_12_2 /usr/local/instantclient && \
    ln -s /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so

ENV LD_LIBRARY_PATH /usr/local/instantclient
ENV TNS_ADMIN       /usr/local/instantclient
ENV ORACLE_BASE     /usr/local/instantclient
ENV ORACLE_HOME     /usr/local/instantclient

RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8-3.0.1

RUN docker-php-ext-configure oci8 --with-oci8=instantclient,/usr/local/instantclient \
    && docker-php-ext-install oci8

RUN docker-php-ext-install mbstring exif pcntl bcmath gd sockets

RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www