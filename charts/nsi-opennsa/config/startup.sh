export DATABASE=${PGDATABASE}
export DATABASE_USER=${PGUSER}
export DATABASE_PASSWORD=${PGPASSWORD}
export DATABASE_HOST=${PGHOST}
. /home/$USER/venv/bin/activate
exec twistd -ny /config/opennsa.tac
