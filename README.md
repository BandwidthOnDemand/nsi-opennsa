# nsi-opennsa
Helm chart and container with additional support to deploy
[OpenNSA](https://github.com/NORDUnet/opennsa) as part of a
[NSI-node](https://github.com/BandwidthOnDemand/nsi-node) deployement.

## standalone deployment

### configuration

Edit the OpenNSA configuration file `charts/nsi-opennsa/config/opennsa.conf` and 
update at least the following:

* `domain`
  * the domain this OpenNSA is authoritative for
* `host`
  * the host as advertised as part of the URL's in the discovery file
* `dbhost`
  * update the helm instance name and namespace

Edit the network resource map `charts/nsi-opennsa/config/opennsa.nrm` to reflect
the NSI exposed topology.

Add the trusted certificates to `charts/nsi-opennsa/certificates` and make sure that
the files are named like `<hash>.0`, for example:

```shell
hash=`openssl x509 -noout -hash -in host.crt`
ln -s host.cert ${hash}.0
```

Add custom backends to `charts/nsi-opennsa/backends`, if any. The backends can
then be referenced from your `opennsa.conf`. If the nsi-opennsa container is missing
Python modules that are needed by a backend please create an issue so support
can be added.

Edit `service` and `ingress` in `charts/nsi-opennsa/values.yaml` to reflect the way
OpenNSA is exposed to the Internet.

### deploy

```shell
helm repo add bitnami https://charts.bitnami.com/bitnami
helm dependency update charts/nsi-opennsa
kubectl create secret generic example-secret --from-literal=POSTGRES_PASSWORD="`head -c 33 /dev/urandom | base64`"
helm upgrade --install --set postgresql.postgresqlPassword=$POSTGRES_PASSWORD example charts/nsi-opennsa
```