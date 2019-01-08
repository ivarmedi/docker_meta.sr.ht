FROM alpine:3.8

RUN apk add ca-certificates && \
    wget -qO /etc/apk/keys/alpine@sr.ht.rsa.pub "https://mirror.sr.ht/alpine/sr.ht/alpine%40sr.ht.rsa.pub" && \
    echo "https://mirror.sr.ht/alpine/sr.ht" >> /etc/apk/repositories && \
    echo "https://mirror.sr.ht/alpine/prometheus/" >> /etc/apk/repositories && \
    echo "@edge http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    echo "@community http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add \
    meta.sr.ht \
    py3-pystache@testing \
    py3-flask-login@community \
    py3-beautifulsoup4@community \
    py3-psycopg2 \
    py3-stripe \
    py3-weasyprint \
    py3-cssselect2 \
    py3-tinycss2 \
    py3-cairocffi@testing \
    py3-pyphen@testing \
    pango \
    py3-cairosvg \
    py3-defusedxml \
    py3-pillow \
    py3-markdown \
    py3-pdfrw@community \
    nginx && \
    mkdir -p /run/nginx

COPY sr.ht.conf /etc/nginx/conf.d
COPY start.sh /opt/start.sh
COPY init.py /opt/init.py
COPY alembic.ini.example /etc/sr.ht/alembic.ini.example

CMD /opt/start.sh
