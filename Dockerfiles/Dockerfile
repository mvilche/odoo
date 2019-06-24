FROM alpine:3.9
ENV PYTHON_VERSION=python2 ODOO_VERSION=8.0 ODOO_REPO=https://github.com/odoo/odoo.git
RUN apk add --no-cache --update $PYTHON_VERSION py2-pip shadow su-exec nodejs npm wkhtmltopdf tzdata postgresql-dev git zlib zlib-dev libjpeg gcc libxml2 libxslt-dev py2-lxml libxml2-dev libc-dev python2-dev jpeg-dev linux-headers openldap-dev tiff-dev
RUN pip install --upgrade pip && npm install -g less && pip install pillow -U && addgroup -S odoo && adduser -h /opt/app -S -G odoo odoo
RUN cd /tmp && git clone --depth=1 -b $ODOO_VERSION $ODOO_REPO && cd /tmp/odoo && pip install -r requirements.txt && pip install pillow -U &&  pip install suds &&  pip install python-ldap -U && \
rm -rf /tmp/odoo /var/cache/apk/*
RUN git clone -b py2.x https://github.com/aeroo/aeroolib.git /tmp/aeroolib && cd /tmp/aeroolib && python setup.py install && rm -rf /tmp/aeroolib
RUN pip install suds-jurko
WORKDIR /opt/app
EXPOSE 8070
COPY run.sh /usr/bin/run.sh
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["-c", "/opt/app/odoo/odoo.cfg"]
