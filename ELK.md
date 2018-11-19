# Elasticsearch - Logstash - Kibana (ELK) framework

## Command snippets
* Simple matches
     curl -XPOST 'localhost:9200/_search' -d '{"query": { "match_all": {} } }'
     curl -XPOST 'localhost:9200/_search' -d '{"query": { "match": { "pool_name": "pool-p1-1-data" } } }'

* Aggregations
     curl -XPOST 'localhost:9200/_search' -d '{"aggs": { "all_interests": { "terms": {"field": "size"} } } }'
     curl -XPOST 'localhost:9200/_search' -d '{"aggs": { "queries": { "terms": {"field": "size"} } } }'
     
     curl -XPOST 'localhost:9200/_search' -d '{"query": { "match": { "pool_name": "pool-p1-1-data" } }, "aggs": { "all_interests": { "terms": {"field": "size"} } } }'
     curl -XPOST 'localhost:9200/_search' -d '{"query": { "match": { "pool_name": "pool-p1-1-data" } }, "aggs": { "queries": { "terms": {"field": "size"} } } }'

* "filtered" is outdated --> Does not work
     curl -XPOST 'localhost:9200/_search' -d '{"query": { "filtered": { "terms": {"field": "size"} } } }'

* Use "bool" instead
     curl -XPOST 'localhost:9200/_search' -d '{"query": { "bool": { "filter": { "term": {"error_code": "0"} } } } }'


* Filtered by pool_name and error_code = 0 
     curl -XPOST 'localhost:9200/_search' -d '
     {"query": { "bool": { 
        "must": {
        "match": {
          "pool_name": "pool-p1-1-data"
        }
      },
      "filter": { "term": {"error_code": "0"} } } } }'

* Testing Atlas anomaly algorithm
     curl -XPOST 'localhost:9200/_search' -d '
     {
     "query": {
      "bool": {
       "filter": {
        "range": {
         "timestamp": {
          "gte": "{{start}}",
          "lte": "{{end}}"
          }
         }
        }
       }
      }
     }'

     curl -XPOST 'localhost:9200/_validate/query?explain' -d '
     {
     "query": {
      "bool": {
       "filter": {
        "range": {
         "timestamp": {
          "gte": "{{start}}",
          "lte": "{{end}}"
          }
         }
        }
       }
      }
     }'


