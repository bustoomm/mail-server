#Sesuain aja pake distributor apa, dan sesuain juga bash nya
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y postfix dovecot-core dovecot-imapd dovecot-pop3d libsasl2-modules

COPY postfix/main.cf /etc/postfix/main.cf
COPY dovecot/dovecot.conf /etc/dovecot/dovecot.conf
COPY dovecot/conf.d/10-mail.conf /etc/dovecot/conf.d/10-mail.conf
COPY ssl/server.crt /etc/ssl/certs/server.crt
COPY ssl/server.key /etc/ssl/private/server.key

RUN chown dovecot:dovecot /etc/ssl/certs/server.crt /etc/ssl/private/server.key

EXPOSE 25 143 110

CMD service postfix start && service dovecot start && tail -f /dev/null
