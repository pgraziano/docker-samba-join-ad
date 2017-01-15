FROM debian:stable

MAINTAINER Florian JUDITH <florian.judith.b@gmail.com>

ENV TERM=xterm

ENV DEBIAN_FRONTEND noninteractive

RUN set -x && \
    apt-get -y update && \
    apt-get -y install \
        sssd \
        vim \
        nano \
        crudini \
        dbus \
        realmd \
        adcli \
        samba-common-bin \
        samba \
        sssd-tools \
        supervisor

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/lib/samba/private && \
    systemctl enable sssd

RUN chmod g+rwx /home

RUN env --unset=DEBIAN_FRONTEND

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh
COPY assets/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 137 138 139 445

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]





