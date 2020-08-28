FROM ubuntu:bionic

# debs
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
	apt-get -y install apt-utils && \
	apt-get -y install supervisor git openssh-server pwgen apache2 mariadb-server libapache2-mod-php php php-cli php-mysql php-gd php-imap php-curl php-xml php-mbstring php-zip mc unzip && \
	apt-get -y install gammu gammu-smsd

# apache2
ADD start-apache2.sh /start-apache2.sh
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD apache_default /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN a2enmod rewrite
RUN rm -rf /var/www/html/*

# gammu
RUN mkdir -p /var/spool/gammu/{inbox,outbox,sent,error}; chown gammu.gammu -Rf /var/spool/gammu/
COPY gammu-smsdrc .
RUN /etc/init.d/gammu-smsd start

# playsms
ADD start-playsmsd.sh /start-playsmsd.sh
ADD supervisord-playsmsd.conf /etc/supervisor/conf.d/supervisord-playsmsd.conf
RUN rm -rf /app && mkdir /app && git clone --branch 1.4.3 --depth=1 https://github.com/antonraharja/playSMS.git /app
ADD install.conf /app/install.conf
ADD install.sh /install.sh

# php
ENV PHP_UPLOAD_MAX_FILESIZE 20M
ENV PHP_POST_MAX_SIZE 20M

# finalize scripts
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 80
#CMD ["/run.sh"]
