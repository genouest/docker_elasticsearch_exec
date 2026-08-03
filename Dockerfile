FROM docker.elastic.co/elasticsearch/elasticsearch:8.19.19

USER root

RUN apt-get -q update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
        python3 python3-pip python3-venv python-is-python3 git nano \
    && rm -rf /var/lib/apt/lists/*

RUN rm -f /usr/lib/python3.12/EXTERNALLY-MANAGED

ADD entrypoint.sh /
ADD /scripts/ /scripts/

ENV RUN_USER='elasticsearch' \
    ES_USER='elasticsearch'

ENTRYPOINT ["/entrypoint.sh"]
