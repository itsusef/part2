#!/bin/sh

set -e 
# Create a default config
if [ ! -f /var/www/html/htdocs/conf/conf.php ]; then
	cat <<-EOF > /var/www/html/htdocs/conf/conf.php
		<?php
		// Config file for Dolibarr ${DOLI_VERSION} ($(date))

		// ###################
		// # Main parameters #
		// ###################
		\$dolibarr_main_url_root='${DOLI_URL_ROOT}';
		\$dolibarr_main_document_root='/var/www/html/htdocs';
		\$dolibarr_main_url_root_alt='/custom';
		\$dolibarr_main_document_root_alt='/var/www/html/htdocs/custom';
		\$dolibarr_main_data_root='/var/www/documents';
		\$dolibarr_main_db_host='${DOLI_DB_HOST}';
		\$dolibarr_main_db_port='${DOLI_DB_PORT}';
		\$dolibarr_main_db_name='${DOLI_DB_NAME}';
		\$dolibarr_main_db_prefix='${DOLI_DB_PREFIX}';
		\$dolibarr_main_db_user='${DOLI_DB_USER}';
		\$dolibarr_main_db_pass='${DOLI_DB_PASSWORD}';
		\$dolibarr_main_db_type='${DOLI_DB_TYPE}';
		\$dolibarr_main_db_character_set='${DOLI_DB_CHARACTER_SET}';
		\$dolibarr_main_db_collation='${DOLI_DB_COLLATION}';

		// ##################
		// # Login          #
		// ##################
		\$dolibarr_main_authentication='${DOLI_AUTH}';


		// ##################
		// # Security       #
		// ##################
		\$dolibarr_main_prod='${DOLI_PROD}';
		\$dolibarr_main_force_https='${DOLI_HTTPS}';
		\$dolibarr_main_restrict_os_commands='mysqldump, mysql, pg_dump, pgrestore';
		\$dolibarr_nocsrfcheck='${DOLI_NO_CSRF_CHECK}';
		\$dolibarr_main_cookie_cryptkey='$(openssl rand -hex 32)';
		\$dolibarr_mailing_limit_sendbyweb='0';
		EOF

chmod 440 /var/www/html/htdocs/conf/conf.php

cd ${APACHE_DOCUMENT_ROOT}/htdocs/install

php step2.php set
php step5.php 0 0 ${LANG:-fr_FR} set ${DOLI_ADMIN_LOGIN} ${DOLI_ADMIN_PASSWORD} ${DOLI_ADMIN_PASSWORD}

fi

chown -R www-data:www-data /var/www/
. /etc/apache2/envvars
echo "Args: ${@}"
exec "$@"