# Cookbook

## Running ELK stack in a ATLAS Tier2 site

* Cloning the main command and generating ELK templates

    $  git clone https://github.com/HappyFaceGoettingen/mad-gantry.git

    $  cd mad-gantry

    $  ./mad-gantry -b -t templates/docker-elk

    $  ./mad-gantry -D -a setup

    $ ls payloads/data/GoeGridELK

    billing  elasticsearch_index_data

* Copy billing logs into the billing directory

* Turn GoeGridELK instance up

    $  ./mad-gantry -s GoeGridELK -a up

    $ docker ps

## Manipulating Kibana Visualisation

## Manipulating Kibana Dashboard


## Saving Kibana dashboard
In our case, we implemented our own darshboard (ID: WeXmuoICywmhE8FvCht). So, exporting the JSON output, and re-using it when the service is up again.

     $ GET http://localhost:20261/api/kibana/dashboards/export?dashboard=AWeXmuoICywmhE8FvCht > export.json
     $ curl -u elastic:changeme -k -XPOST 'http://localhost:20261/api/kibana/dashboards/import' -H 'Content-Type: application/json' -H "kbn-xsrf: true" -d @export.json


## Command snippets for Elasticsearch
There are many client tools for Elasticsearch. These can most easily be communicated through REstFul web service in Elasticsearch engine.

* List indexes

     $ curl 'localhost:9200/_cat/indices?v'

* Filter if error_code in billing log is '0'

     $ curl -XPOST 'localhost:9200/_search' -d '{"query": { "bool": { "filter": { "term": {"error_code": "0"} } } } }'

* Simple matches using pool_name in 'billing log'

     $ curl -XPOST 'localhost:9200/_search?pretty=true' -d '{"query": { "match_all": {} } }'

     $ curl -XPOST 'localhost:9200/_search?pretty=true' -d '{"query": { "match": { "pool_name": "pool-p1-1-data" } } }'

* Aggregations

     $ curl -XPOST 'localhost:9200/_search' -d '{"aggs": { "all_interests": { "terms": {"field": "size"} } } }'
     $ curl -XPOST 'localhost:9200/_search' -d '{"aggs": { "queries": { "terms": {"field": "size"} } } }'
     
     $ curl -XPOST 'localhost:9200/_search' -d '{"query": { "match": { "pool_name": "pool-p1-1-data" } }, "aggs": { "all_interests": { "terms": {"field": "size"} } } }'
     $ curl -XPOST 'localhost:9200/_search' -d '{"query": { "match": { "pool_name": "pool-p1-1-data" } }, "aggs": { "queries": { "terms": {"field": "size"} } } }'

