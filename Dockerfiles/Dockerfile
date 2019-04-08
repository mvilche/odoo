FROM alpine:3.9
ENV PYTHON_VERSION=python3 ODOO_VERSION=11.0 ODOO_REPO=https://github.com/odoo/odoo.git
RUN apk add --no-cache --update $PYTHON_VERSION shadow su-exec nodejs npm wkhtmltopdf tzdata postgresql-dev git gcc libxml2 libxslt-dev py3-lxml libxml2-dev libc-dev python3-dev jpeg-dev py3-psutil linux-headers openldap-dev tiff-dev && \
pip3 install --upgrade pip && cd /tmp && git clone --depth=1 -b $ODOO_VERSION $ODOO_REPO && cd /tmp/odoo && pip3 install -r requirements.txt && npm install -g less && \
addgroup -S odoo && adduser -h /opt/app -S -G odoo odoo && \
rm -rf /tmp/odoo /var/cache/apk/*
WORKDIR /opt/app
EXPOSE 8070
COPY run.sh /usr/bin/run.sh
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["-c", "/opt/app/odoo/odoo.cfg"]
