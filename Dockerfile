FROM docker.elastic.co/elasticsearch/elasticsearch:8.19.19

USER root

RUN apt-get -q update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
        python3 python-is-python3 git nano curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Stop crashes when installing packages
RUN rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED

# Manually install pip, else we can't upgrade it later
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python

ADD entrypoint.sh /
ADD /scripts/ /scripts/

ENV RUN_USER='elasticsearch' \
    ES_USER='elasticsearch'

ENTRYPOINT ["/entrypoint.sh"]
