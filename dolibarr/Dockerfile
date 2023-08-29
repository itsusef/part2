FROM debian:bookworm-slim


ENV DOLI_VERSION 17.0.3
ENV APACHE_DOCUMENT_ROOT /var/www/html/

# Set Mariadb credentials & connection details
ENV DOLI_DB_TYPE mysqli
ENV DOLI_DB_HOST db
ENV DOLI_DB_PORT 3306
ENV DOLI_DB_USER dolibarr
ENV DOLI_DB_PASSWORD dolibarrpwd123
ENV DOLI_DB_NAME dolibarr
ENV DOLI_DB_PREFIX llx_
ENV DOLI_DB_CHARACTER_SET utf8
ENV DOLI_DB_COLLATION utf8_unicode_ci

ENV DOLI_DB_ROOT_LOGIN ''
ENV DOLI_DB_ROOT_PASSWORD ''

ENV DOLI_ADMIN_LOGIN admin
ENV DOLI_ADMIN_PASSWORD dolibarr
ENV DOLI_MODULES ''

ENV DOLI_URL_ROOT 'http://localhost'

ENV DOLI_AUTH dolibarr
ENV DOLI_HTTPS 0
ENV DOLI_PROD 0
ENV DOLI_NO_CSRF_CHECK 0

ENV LANG fr_FR



RUN apt update && apt install -y wget gnupg2 lsb-release\
    && wget https://packages.sury.org/php/apt.gpg && apt-key add apt.gpg\
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list


# Install required packages and dependencies
RUN apt update && apt install -qqy apache2 php8.1\
    php8.1-mysql php8.1-curl php8.1-gd php8.1-ldap\
    php8.1-cli php8.1-common php8.1-zip php8.1-mbstring \
    php8.1-xml php8.1-bcmath php8.1-intl php-pear php-mail-mime\
    php8.1-imap mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean


RUN sed -i 's|/var/www/html|/var/www/html/htdocs|g' /etc/apache2/sites-available/000-default.conf

# Download and extract Dolibarr
RUN wget  https://www.dolibarr.fr/files/stable/standard/dolibarr-${DOLI_VERSION}.tgz -P /tmp/ \
    && tar -xzf /tmp/dolibarr-${DOLI_VERSION}.tgz -C ${APACHE_DOCUMENT_ROOT} --strip-components=1 \
    # && cp -R  ${APACHE_DOCUMENT_ROOT}/htdocs/* /var/www/html/ \
    && mkdir /var/www/documents\
    && chown -R www-data:www-data /var/www/\
    && rm ${APACHE_DOCUMENT_ROOT}index.html

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
    service apache2 restart

WORKDIR /var/www/html

COPY ./entrypoint.sh /tmp/
RUN chmod +x /tmp/entrypoint.sh
# Expose port 80 for the Apache web server
EXPOSE 80

# # Start the Apache web server
ENTRYPOINT ["/tmp/entrypoint.sh"]
# CMD ["/bin/bash","-c","/var/www/html/entrypoint.sh"]
CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]


# FROM debian:bookworm-slim


# ENV DOLI_VERSION 17.0.3
# ENV APACHE_DOCUMENT_ROOT /var/www/html/

# # Set Mariadb credentials & connection details
# ENV DOLI_DB_TYPE mysqli
# ENV DOLI_DB_HOST db
# ENV DOLI_DB_PORT 3306
# ENV DOLI_DB_USER dolibarr
# ENV DOLI_DB_PASSWORD dolibarrpwd123
# ENV DOLI_DB_NAME dolibarr
# ENV DOLI_DB_PREFIX llx_
# ENV DOLI_DB_CHARACTER_SET utf8
# ENV DOLI_DB_COLLATION utf8_unicode_ci

# ENV DOLI_DB_ROOT_LOGIN ''
# ENV DOLI_DB_ROOT_PASSWORD ''

# ENV DOLI_ADMIN_LOGIN admin
# ENV DOLI_ADMIN_PASSWORD dolibarr
# ENV DOLI_MODULES ''

# ENV DOLI_URL_ROOT 'http://localhost'

# ENV DOLI_AUTH dolibarr
# ENV DOLI_HTTPS 0
# ENV DOLI_PROD 0
# ENV DOLI_NO_CSRF_CHECK 0

# ENV LANG fr_FR



# RUN apt update && apt install -y wget gnupg2 lsb-release\
#     && wget https://packages.sury.org/php/apt.gpg && apt-key add apt.gpg\
#     && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list


# # Install required packages and dependencies
# RUN apt update && apt install -qqy apache2 php8.1\
#     php8.1-mysql php8.1-curl php8.1-gd php8.1-ldap\
#     php8.1-cli php8.1-common php8.1-zip php8.1-mbstring \
#     php8.1-xml php8.1-bcmath php8.1-intl php-pear php-mail-mime\
#     php8.1-imap mariadb-client \
#     && rm -rf /var/lib/apt/lists/* \
#     && apt-get clean


# RUN sed -i 's|/var/www/html|/var/www/html/htdocs|g' /etc/apache2/sites-available/000-default.conf

# # Download and extract Dolibarr
# RUN wget  https://www.dolibarr.fr/files/stable/standard/dolibarr-${DOLI_VERSION}.tgz -P /tmp/ \
#     && tar -xzf /tmp/dolibarr-${DOLI_VERSION}.tgz -C ${APACHE_DOCUMENT_ROOT} --strip-components=1 \
#     && rm -r /tmp/dolibarr-${DOLI_VERSION}.tgz\
#     && mkdir /var/www/documents\
#     && chown -R www-data:www-data /var/www/\
#     && rm ${APACHE_DOCUMENT_ROOT}index.html

# RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf &&\
#     service apache2 restart

# WORKDIR /var/www/html

# COPY ./entrypoint.sh .
# RUN chmod +x entrypoint.sh

# # Expose port 80 for the Apache web server
# EXPOSE 80

# # # Start the Apache web server
# ENTRYPOINT ["./entrypoint.sh"]

# CMD ["/usr/sbin/apache2", "-D", "FOREGROUND"]