#!/bin/bash

# Send the epoch time to an index "timestamp"
#  epoch: current time
#  t0 : start time of script

DOCKER_NAME=default
DOCKER_IP=$(docker-machine ip ${DOCKER_NAME})

## send the visualization
# curl -XPOST -d @kibana/epoch_visualization.json \
#     http://${DOCKER_IP}:5601/elasticsearch/.kibana/visualization/Epoch-Time

init_time=$(/bin/date +%s)
while [ 1 ]
do curl --silent -XPUT  -H "content-type: application/json" \
	-d "{\"epoch\":$(/bin/date +%s),\"t0\":${init_time}}" \
	http://${DOCKER_IP}:8080/timestamp >& /dev/null;
   sleep 5;
done
