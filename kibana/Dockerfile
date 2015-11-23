FROM kibana

COPY kibana.yml /opt/kibana/config/

## ##  local fix for https://github.com/elastic/kibana/pull/4969
## no longer necessary
# RUN chmod a+r /opt/kibana/src/public/worker-json.js

