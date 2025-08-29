FROM ubuntu:24.04

RUN apt-get	update && apt-get install -y wget build-essential git unzip \
&& mkdir -p /opt && mkdir -p /opt/bin && cd /tmp && git co https://github.com/ioquake/mpdirectory.git && cd /tmp/mpdirectory/src && make release \
&& mv /tmp/mpdirectory/src/mpdirectory /opt/bin/mpdirectory \
&& adduser --disabled-password --gecos "mpdirectory user" mpdirectory \
&& apt-get purge -y build-essential unzip \
&& apt-get autoremove -y \
&& rm -rf /staging \
&& rm -rf /tmp/* /var/tmp/* \
&& rm -rf /var/lib/apt/lists/* \
&& rm -rf /opt/mpdirectory

EXPOSE 27950/udp

USER mpdirectory

CMD /opt/bin/mpdirectory -f
