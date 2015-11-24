FROM elasticsearch

COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY logging.yml /usr/share/elasticsearch/config/

## not updated yet
# RUN /usr/share/elasticsearch/bin/plugin install lukas-vlcek/bigdesk

RUN /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ

# install elasticsearch/marvel/latest
# install mobz/elasticsearch-head

ENV ES_HEAP_SIZE 150m