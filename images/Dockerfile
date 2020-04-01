FROM php:7.3-apache
COPY files/000-default.conf /etc/apache2/sites-available/000-default.conf
COPY files/apache2.conf /etc/apache2/apache2.conf
RUN a2enmod expires
RUN a2enmod headers
RUN curl -o /bin/wp-cli https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /bin/wp-cli
RUN apt-get update && apt-get install default-mysql-client less vim libpng-dev libjpeg-dev -y \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mysqli opcache
ARG wp_version
ARG wp_db_host
ARG wp_db_user
ARG wp_db_pass
ARG wp_db_name
ARG wp_url
ARG wp_title
ARG wp_admin_user
ARG wp_admin_pass
ARG wp_admin_email
WORKDIR /var/www/html
RUN wp-cli core download --version=$wp_version --allow-root \
    && wp-cli core config --dbhost=$wp_db_host --dbuser=$wp_db_user --dbpass=$wp_db_pass --dbname=$wp_db_name --allow-root \
    && wp-cli core install --url=$wp_url --title="$wp_title" --admin_user=$wp_admin_user --admin_password=$wp_admin_pass --admin_email=$wp_admin_email --allow-root \
    && chown -R www-data.www-data /var/www/html
#COPY object-cache.php wp-content/
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*