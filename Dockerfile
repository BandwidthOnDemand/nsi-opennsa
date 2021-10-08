# OpenNSA docker image

FROM debian:stable-slim

MAINTAINER Henrik Thostrup Jensen <htj@nordu.net>


# -- Environment --
ENV OPENNSA_GIT_REPO https://github.com/NORDUnet/opennsa.git
ENV OPENNSA_VERSION eddf14f94a6e0d183c70f7465ba466ddc951c2fd
ENV USER opennsa


# --- Base image ---
# Update and install dependencies
# pip to install twistar service-identity pyasn1
# pyasn1 and crypto is needed for ssh backends
RUN apt-get update && apt-get install -y git-core python3 python3-twisted-bin python3-openssl python3-psycopg2 python3-pip python3-cryptography python3-dateutil python3-distutils python3-requests

# requests is needed for workflowengine backend
RUN pip3 install twistar service-identity pyasn1


# -- User setup --
RUN adduser --disabled-password --gecos 'OpenNSA user' $USER


# -- Install OpenNSA --
USER $USER
WORKDIR /home/$USER

RUN git clone $OPENNSA_GIT_REPO && cd opennsa && git checkout $OPENNSA_VERSION

# -- Cleanup --
# With --squash this makes the image go from 476 to 164 mb
USER root
RUN apt-get remove -y python3-pip git
RUN apt-get -y clean
RUN apt-get -y autoclean
RUN apt-get -y autoremove


# -- Switch to OpenNSA directory --

USER $USER
WORKDIR /home/$USER/opennsa

ENV PYTHONPATH .

# -- Entrypoint --

EXPOSE 9080
EXPOSE 9443

ENTRYPOINT rm -f twistd.pid; twistd -ny opennsa.tac
