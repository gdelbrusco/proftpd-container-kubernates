FROM ubuntu:bionic
RUN             apt update && \
            apt upgrade -y && \
            apt install gosu -y && \
            apt install proftpd-basic -y && \
            apt clean autoclen && \
            apt autoremove --yes && \
            rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN sed -i -e '/UseIPv6/ s/on/off/' /etc/proftpd/proftpd.conf
RUN echo "ScoreboardFile /dev/null" >> /etc/proftpd/proftpd.conf
RUN echo "PidFile /home/proftpd/proftpd.pid" >> /etc/proftpd/proftpd.conf
RUN echo "DelayTable /home/proftpd/proftpd.delay" >> /etc/proftpd/proftpd.conf
RUN echo "Include /configfile/" >> /etc/proftpd/proftpd.conf
RUN sed -i -e '/Port/ s/21/8021/' /etc/proftpd/proftpd.conf
#RUN mkdir /etc/proftpd/authuserfile
#RUN mkdir /etc/proftpd/group

COPY group /etc/proftpd/
COPY authuserfile /etc/proftpd/
#COPY hidden.conf /etc/proftpd/conf.d

RUN chmod 640 /etc/proftpd/group && chmod 640 /etc/proftpd/authuserfile
RUN chown proftpd /etc/proftpd/group /etc/proftpd/authuserfile
RUN chown proftpd -R /var/log/proftpd
#RUN chmod 777 /run/proftpd
RUN usermod --shell /bin/bash proftpd
RUN mkdir /home/proftpd
RUN chown proftpd /home/proftpd
RUN usermod -d /home/proftpd proftpd

EXPOSE 8021

COPY entrypoint.sh /

USER proftpd
ENTRYPOINT ["/entrypoint.sh"]
CMD ["proftpd", "-n"]
