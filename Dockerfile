FROM docker.io/leo6/baseimage
##MAINTAINER liuliangliang


RUN yum install -y bind bind-chroot bind-utils  \


&& sed -i 's/127.0.0.1/any/g' /etc/named.conf \
&& sed -i 's/localhost/any/g' /etc/named.conf \


&& echo 'zone "cootalk.com" IN {' >>/etc/named.rfc1912.zones \
&& echo 'type master;' >>/etc/named.rfc1912.zones \
&& echo 'file "cootalk.com.zone";' >>/etc/named.rfc1912.zones \
&& echo 'allow-update { none; };' >>/etc/named.rfc1912.zones \
&& echo '};' >>/etc/named.rfc1912.zones \
&& cp /var/named/named.empty /var/named/cootalk.com.zone \
&& echo 'mysql.cootalk.com.  IN  A  127.0.0.1'  >>/var/named/cootalk.com.zone \
&& echo 'notify.cootalk.com.  IN  A  127.0.0.1' >>/var/named/cootalk.com.zone \
&& echo 'ejabberd.cootalk.com.  IN  A  127.0.0.1' >>/var/named/cootalk.com.zone \
&& echo 'redis.cootalk.com.  IN  A  127.0.0.1' >>/var/named/cootalk.com.zone \
&& echo 'tracker.cootalk.com.  IN  A  127.0.0.1' >>/var/named/cootalk.com.zone \
&& echo 'storage.cootalk.com.  IN  A  127.0.0.1' >>/var/named/cootalk.com.zone \
&& chmod 777 /var/named/cootalk.com.zone \

&& echo 'zone "cootel.com" IN {' >>/etc/named.rfc1912.zones \
&& echo 'type master;' >>/etc/named.rfc1912.zones \
&& echo 'file "cootel.com.zone";' >>/etc/named.rfc1912.zones \
&& echo 'allow-update { none; };' >>/etc/named.rfc1912.zones \
&& echo '};' >>/etc/named.rfc1912.zones \

&& cp /var/named/named.empty /var/named/cootel.com.zone \
&& echo 'service.cootel.com.  IN  A  127.0.0.1' >>/var/named/cootel.com.zone \
&& echo 'talkapp.cootel.com.  IN  A  127.0.0.1' >>/var/named/cootel.com.zone \
&& echo 'talkim.cootel.com.  IN  A  127.0.0.1' >>/var/named/cootel.com.zone \
&& echo 'talkfile.cootel.com.  IN  A  127.0.0.1' >>/var/named/cootel.com.zone \
&& chmod 777 /var/named/cootel.com.zone \
&& yum clean all

ADD file/supervisord.conf /etc/

CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
