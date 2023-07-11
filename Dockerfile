FROM docker.elastic.co/elasticsearch/elasticsearch:8.7.0

USER root

RUN apt-get -q update \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq --no-install-recommends install \
        python3 python3-pip git \
    && rm -rf /var/lib/apt/lists/*

ADD entrypoint.sh /
ADD /scripts/ /scripts/

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/bin/bash"]
