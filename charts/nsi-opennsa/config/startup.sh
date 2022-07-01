export DATABASE_HOST=`echo $DATABASE_URI | sed "s|^postgresql://$DATABASE_USERNAME@[^@]*@\([^:]*\).*$|\1|"`
exec twistd -ny /config/opennsa.tac
