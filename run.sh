#!/bin/bash

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php/7.2/apache2/php.ini

echo "=> Installing playSMS ..."
/install.sh
echo "=> Configuring Gammu"
exec gammu-smsd --config /etc/gammu-smsdrc
echo "=> Done!"


echo "=> Exec supervisord"
exec supervisord -n
