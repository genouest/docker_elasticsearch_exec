FROM docker.elastic.co/elasticsearch/elasticsearch:8.7.0

USER root

RUN apt-get -q update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
        python3 python3-pip python-is-python3 git \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /
ADD /scripts/ /scripts/

ENV RUN_USER='elasticsearch' \
    ES_USER='elasticsearch'

ENTRYPOINT ["/entrypoint.sh"]
