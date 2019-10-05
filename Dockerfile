FROM alpine:3.10
ENV PYTHON_VERSION=python3 ODOO_VERSION=11.0 ODOO_REPO=https://github.com/odoo/odoo.git
RUN apk add --no-cache --update $PYTHON_VERSION shadow su-exec nodejs npm wkhtmltopdf tzdata postgresql-dev git gcc libxml2 libxslt-dev py3-lxml libxml2-dev libc-dev python3-dev jpeg-dev py3-psutil linux-headers openldap-dev tiff-dev && \
pip3 install --upgrade pip
RUN mkdir -p /opt && cd /opt && git clone --depth=1 -b $ODOO_VERSION $ODOO_REPO && cd /opt/odoo && pip3 install -r requirements.txt && npm install -g less
COPY run.sh /usr/bin/run.sh
RUN curl -SL -o nss_wrapper.tar.gz https://ftp.samba.org/pub/cwrap/nss_wrapper-1.1.2.tar.gz && \
 mkdir nss_wrapper && \
 tar -xC nss_wrapper --strip-components=1 -f nss_wrapper.tar.gz && \
 rm nss_wrapper.tar.gz && \
 mkdir nss_wrapper/obj && \
 (cd nss_wrapper/obj && \
 cmake -DCMAKE_INSTALL_PREFIX=/usr/local -DLIB_SUFFIX=64 .. && \
 make && \
 make install) && \
 rm -rf nss_wrapper
RUN mkdir -p /opt/odoo/server-config && rm -rf /etc/localtime  && touch /etc/timezone /etc/localtime && \
adduser -D -u 1001 -h /opt/odoo odoo && \
usermod -aG 0 odoo && \
chown 1001 -R /opt /usr/bin/run.sh /etc/timezone /etc/localtime  && \
chgrp -R 0 /opt /usr/bin/run.sh /etc/timezone /etc/localtime && \
chmod g=u -R /opt /usr/bin/run.sh /etc/timezone /etc/localtime && \
chmod +x /opt/odoo/odoo-bin /usr/bin/run.sh && \
rm -rf /var/cache/apk/*
WORKDIR /opt/odoo
EXPOSE 8070
ENV HOME /opt/odoo
USER 1001
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["-c", "/opt/odoo/server-config/odoo.cfg"]
