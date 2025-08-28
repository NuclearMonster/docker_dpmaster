FROM ubuntu:24.04

RUN apt-get	update && apt-get install -y wget build-essential unzip \
&& mkdir -p /opt && cd /opt && wget http://icculus.org/twilight/darkplaces/files/dpmaster-2.2.zip && unzip dpmaster-2.2.zip && cd /opt/dpmaster-2.2/src && make release \
&& mv /opt/dpmaster-2.2/src/dpmaster /opt/ \
&& adduser --disabled-password --gecos "dpmaster user" dpmaster \
&& apt-get purge -y wget build-essential unzip \
&& apt-get autoremove -y \
&& rm -rf /staging \
&& rm -rf /tmp/* /var/tmp/* \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /opt/dpmaster-2.2 \
&& rm -f /opt/dpmaster-2.2.zip

EXPOSE 27950/udp

USER dpmaster

CMD /opt/dpmaster -f
