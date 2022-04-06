FROM centos:7
RUN yum update -y
RUN yum install -y git https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y --enablerepo=remi-php80 php php-cli php-zip php-mysql php-mcrypt php-xml php-mbstring
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/bin/composer && chmod +x /usr/bin/composer

RUN cd /var/www && git clone https://github.com/laravel/laravel.git -b 8.x
RUN cd /var/www/laravel && composer install
RUN chown -R apache.apache /var/www/laravel && chmod -R 777 /var/www/laravel && chmod -R 777 /var/www/laravel/storage
#RUN chcon -R -t httpd_sys_rw_content_t /var/www/laravel/storage 
RUN cd /var/www/laravel && cp .env.example .env
RUN cd /var/www/laravel &&php artisan key:generate
COPY laravel.conf /etc/httpd/conf.d/
EXPOSE 80

CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
