#!/bin/sh

# reverse proxy
nginx

# initialize users and db 
python3 /opt/init.py

# alembic
(
cd /usr/lib/python3.6/site-packages/${APPLICATION}srht
[[ -f /etc/sr.ht/alembic.ini ]] || cp /etc/sr.ht/alembic.ini.example /etc/sr.ht/alembic.ini

if [[ -z "$(alembic-3 -c /etc/sr.ht/alembic.ini current)" ]]; then
    alembic-3 -c /etc/sr.ht/alembic.ini stamp head
fi
)

/usr/bin/gunicorn -- ${APPLICATION}srht.app:app_dispatch -b 0.0.0.0:7000
