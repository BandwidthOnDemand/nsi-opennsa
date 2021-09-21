#!/bin/sh
sed -e "s:%POSTGRES_PASSWORD%:$POSTGRES_PASSWORD:" /config/opennsa.conf >/tmp/opennsa.conf
export PYTHONPATH=/backends:$PYTHONPATH
exec twistd -ny /config/opennsa.tac
