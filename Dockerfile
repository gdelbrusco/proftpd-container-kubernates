FROM ubuntu:bionic
RUN     	apt update && \
            apt upgrade -y && \
            apt install proftpd-basic -y && \
            apt clean autoclen && \
            apt autoremove --yes && \
            rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN sed -i -e '/UseIPv6/ s/on/off/' /etc/proftpd/proftpd.conf
#RUN echo "Include /configfile/" >> /etc/proftpd/proftpd.conf
#RUN mkdir /etc/proftpd/authuserfile
#RUN mkdir /etc/proftpd/group
COPY group /etc/proftpd/
COPY authuserfile /etc/proftpd/
COPY hidden.conf /etc/proftpd/conf.d

RUN chmod 640 /etc/proftpd/group && chmod 640 /etc/proftpd/authuserfile

EXPOSE 21

COPY entrypoint.sh /


ENTRYPOINT ["/entrypoint.sh"]
CMD ["proftpd", "-n"]
