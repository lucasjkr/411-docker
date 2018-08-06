#FROM php:7-apache
FROM phusion/baseimage

RUN apt-get update && \
    apt-get -y install \
    curl \
    php7.0 \
    php7.0-mysql \
    unzip \
    git \
    libxml2-dev \
    libcurl4-openssl-dev \
    cron
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer
RUN docker-php-ext-configure \
    pdo_mysql --with-pdo-mysql=mysqlnd
RUN docker-php-ext-install \
    xml \
    pdo_mysql \
    mbstring \
    curl \
    pcntl

RUN a2enmod headers rewrite

WORKDIR /var/www/411
RUN curl -L https://github.com/etsy/411/releases/download/v1.5.0/release.tgz | tar xz
RUN COMPOSER=composer-es6x.json composer install --no-dev --optimize-autoloader

RUN mkdir /data
COPY config/411.conf /data/000-default.conf
RUN ln -sf /data/000-default.conf /etc/apache2/sites-available/000-default.conf

COPY config/config.php .
COPY config/init.php .

RUN chmod ugo+rx -R /data
RUN chown www-data:www-data -R /data

COPY config/mail.ini /usr/local/etc/php/conf.d/
#COPY config/411_cron /etc/cron.d/
# Give execution rights on the cron job
#RUN chmod 0644 /etc/cron.d/411_cron

RUN printf '* * * * * root cd /var/www/411/bin && /usr/local/bin/php cron.php >> /var/log/cron.log 2>&1\n#' >> /root/crontab
RUN printf '* * * * * root cd /var/www/411/bin && /usr/local/bin/php worker.php >> /var/log/cron.log 2>&1\n#' >> /root/crontab
RUN touch /var/log/cron.log

# Create the log file to be able to run tail
#RUN touch /var/log/cron.log

#RUN echo "/usr/sbin/cron -f -L 8 $$ tail -f /var/log/cron.log" > /usr/local/bin/docker-entrypoint.sh

CMD /usr/sbin/cron -f -L 0 && tail -f /var/log/cron.log