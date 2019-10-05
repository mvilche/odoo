FROM alpine:3.10
ENV PYTHON_VERSION=python3 ODOO_VERSION=11.0 ODOO_REPO=https://github.com/odoo/odoo.git
RUN apk add --no-cache --update $PYTHON_VERSION shadow curl nodejs npm wkhtmltopdf tzdata postgresql-dev git gcc libxml2 libxslt-dev py3-lxml libxml2-dev libc-dev python3-dev jpeg-dev py3-psutil linux-headers openldap-dev tiff-dev && \
pip3 install --upgrade pip
RUN mkdir -p /opt && cd /opt && git clone --depth=1 -b $ODOO_VERSION $ODOO_REPO && cd /opt/odoo && pip3 install -r requirements.txt && npm install -g less
COPY run.sh /usr/bin/run.sh
RUN mkdir -p /opt/odoo/server-config /opt/odoo/custom_addons && rm -rf /etc/localtime  && touch /etc/timezone /etc/localtime && \
adduser -D -u 1001 -h /opt/odoo odoo && \
usermod -aG 0 odoo && \
chown 1001 -R /opt /usr/bin/run.sh /etc/timezone /etc/localtime  && \
chgrp -R 0 /opt /usr/bin/run.sh /etc/timezone /etc/localtime && \
chmod g=u -R /opt /usr/bin/run.sh /etc/timezone /etc/localtime && \
chmod +x /opt/odoo/odoo-bin /usr/bin/run.sh && \
chmod g+w /etc/passwd && \
rm -rf /var/cache/apk/*
WORKDIR /opt/odoo
EXPOSE 8070
ENV HOME /opt/odoo
USER 1001
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["-c", "/opt/odoo/server-config/odoo.cfg"]
