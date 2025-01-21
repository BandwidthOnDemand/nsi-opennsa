export DATABASE=${PGDATABASE}
export DATABASE_USER=${PGUSER}
export DATABASE_PASSWORD=${PGPASSWORD}
export DATABASE_HOST=${PGHOST}
exec twistd -ny /config/opennsa.tac
