FROM centos:7
RUN yum install httpd -y
RUN mkdir -p /var/www/first /var/www/second
RUN echo "<h1 style='color:red'>First Website Port 80</h1>" > /var/www/first/index.html
RUN echo "<h1 style='color:blue'>Second Website Port 8080</h1>" > /var/www/second/index.html
COPY both.conf /etc/httpd/conf.d/
RUN echo "Listen 8080" >> /etc/httpd/conf/httpd.conf
EXPOSE 80 8080
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]

# https://hub.docker.com/r/adityamandil317/multi-web-httpd
