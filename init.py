import os, configparser, bcrypt
from metasrht.app import db, cfg, User, UserType

# Change the alembic connection string
alembic = configparser.ConfigParser()
alembic.read('/opt/alembic.ini')
alembic['alembic']['sqlalchemy.url'] = cfg("meta.sr.ht", "connection-string")

with open('/etc/sr.ht/alembic.ini.example', 'w') as configfile:
    alembic.write(configfile)

# Create the schema
db.create()

username = os.environ['USER_NAME'] if os.environ['USER_NAME'] else "admin" 
email = os.environ['USER_EMAIL'] if os.environ['USER_EMAIL'] else "admin@example.com"

try:
    user = User.query.filter_by(username=username).one()
except:
    user = User(username)

user.email = email
user.password = bcrypt.hashpw("password".encode('utf-8'), salt=bcrypt.gensalt()).decode('utf-8')
user.user_type = UserType.admin
db.session.add(user)
db.session.commit()
