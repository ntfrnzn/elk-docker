
## A simple docker-compose ELK stack

This collection is built using docker-compose and docker-machine.  The
logstash client is listening on port 8080 for http PUT requests of
json-formatted log requests. The kibana UI is listening at port 5601.

This stack is quite small and probably not usable for anything
meaningful without additional effort.  Nevertheless, it could be a
useful startng point.

### Quick Start

Assuming that you've already set up docker-machine either with a local
VM or a cloud provider, then it could be as simple as

```
     eval "$(docker-machine env default)"
     docker-compose build
     docker-compose up -d
```

There are a couple of test scripts to send data.

```
   scripts/send_time.sh -d <docker machine name>
```

simply posts the unix time every five seconds.  There is a saved
visualization which can be imported into kibana with

```
   DOCKER_IP=$(docker-machine ip ${DOCKER_NAME})
   curl -XPOST -d @kibana/epoch_visualization.json \
       http://${DOCKER_IP}:5601/elasticsearch/.kibana/visualization/Epoch-Time
```
viewable at http://hostname:5601/#/visualize/edit/Epoch-Time

###  Components

#### Elasticsearch

This is a small-scale single-node development system.  The important
changes in the configuration file are

```
index.number_of_shards: 1
index.number_of_replicas: 0
```

and

```
discovery.zen.ping.multicast.enabled: false
```

The second of this is important when running in Digital Ocean, as
otherwise the logstash agent will not be able to connect to the
elasticsearch cluster at all.

There are a couple of management plugins installed.  These management
UIs are available at http://hostname:9200/_plugin/HQ and
http://hostname:9200/_plugin/bigdesk

#### Logstash

The logstash configuration is set up to listen for incoming
documents. It interprets the first part of the url path as as the
target elasticsearch index name, so a PUT to
http://hostname:8080/new_category will create an index in elasticsearch
called "new_category-YYY.MM.DD"

#### Kibana

The kibana configuration here is out-of-the-box standard


### HAR files

There's a python script to parse and send HAR files.  All it does is
extract the `entries` array from the HAR log element, and post them up
individually. Each of these contains a timestamp `startedDateTime`, so
they can be arranged in sequence in the kibana UI

No useful visualizations for har data have been created yet.