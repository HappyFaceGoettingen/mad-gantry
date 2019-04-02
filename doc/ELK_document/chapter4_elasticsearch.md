# Elasticsearch

Elasticsearch is a real-time distributed search and analytics engine. It allows one to explore data at a speed and at a scale never before possible. It is used for full-text search, structured search, analytics, and all in combination. Elasticsearch is an open-source search engine built on top of Apache Lucene, a fulltext search-engine library. However, Elasticsearch is much more than just Lucene and much more than just full-text search. It can also be described as follows:

* A distributed real-time document store where every field is indexed and searchable
* A distributed search engine with real-time analytics
* Capable of scaling to hundreds of servers and petabytes of structured and unstructured data

And it packages up all this functionality into a standalone server that applications can talk to via a simple RESTful API, using a web client from our favorite programming language, or even from the command line.

For instance, after starting our service up, our simplest example is directly sending a query to the Elasticsearch instance (port 9200 in this case) and get number of indices stored.

      $ curl 'localhost:9200/_cat/indices?v'

