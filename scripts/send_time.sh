#!/bin/bash

# Send the epoch time to an index "timestamp"
#  epoch: current time
#  t0 : start time of script

DOCKER_NAME=default

while getopts ":d:t" opt; do
  case ${opt} in
      d ) 
	  DOCKER_NAME=$OPTARG
	  ;;
      t ) 
	  ;;
      \? ) echo "Usage: cmd [-d]" 
	  ;;
  esac
done

DOCKER_IP=$(docker-machine ip ${DOCKER_NAME})

## howto send the visualization
cat <<EOF
Here's how to post the visualization
curl -XPOST -d @kibana/epoch_visualization.json \\
     --header "kbn-xsrf-token:c069ec5b1a4ca1a16341368f" \\
     http://${DOCKER_IP}:5601/elasticsearch/.kibana/visualization/Epoch-Time

EOF

echo "...now sending timestamps"
init_time=$(/bin/date +%s)
while [ 1 ]
do curl --silent -XPUT  -H "content-type: application/json" \
	-d "{\"epoch\":$(/bin/date +%s),\"t0\":${init_time}}" \
	http://${DOCKER_IP}:8080/timestamp >& /dev/null;
   sleep 5;
done
