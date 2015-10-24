FROM kibana

COPY kibana.yml /opt/kibana/config/

RUN chmod a+r /opt/kibana/src/public/worker-json.js

# ? https://github.com/elastic/kibana/pull/4969
# actually this doesn't seem to resolve the problem