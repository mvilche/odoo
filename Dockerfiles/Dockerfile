FROM alpine:3.9
ENV PYTHON_VERSION=python2 ODOO_VERSION=8.0 ODOO_REPO=https://github.com/odoo/odoo.git AEROOLIB_REPO=https://github.com/aeroo/aeroolib.git AEROOLIB_BRANCH=py2.x
RUN apk add --no-cache --update $PYTHON_VERSION py2-pip shadow su-exec nodejs npm wkhtmltopdf tzdata postgresql-dev git zlib zlib-dev libjpeg gcc libxml2 libxslt-dev py2-lxml libxml2-dev libc-dev python2-dev jpeg-dev linux-headers openldap-dev tiff-dev
RUN pip install --upgrade pip && npm install -g less && pip install pillow -U && addgroup -S odoo && adduser -h /opt/app -S -G odoo odoo
RUN cd /tmp && git clone --depth=1 -b $ODOO_VERSION $ODOO_REPO && cd /tmp/odoo && pip install -r requirements.txt && pip install pillow -U &&  pip install suds && \
pip install python-ldap -U && pip install suds-jurko
RUN git clone --depth=1 -b $AEROOLIB_BRANCH $AEROOLIB_REPO /tmp/aeroolib && cd /tmp/aeroolib && python setup.py install && \
rm -rf /tmp/aeroolib /tmp/odoo /var/cache/apk/*
WORKDIR /opt/app
EXPOSE 8070
COPY run.sh /usr/bin/run.sh
ENTRYPOINT ["/usr/bin/run.sh"]
CMD ["-c", "/opt/app/odoo/odoo.cfg"]
