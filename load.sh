#!/usr/bin/env bash

for f in records/*.json; do
  curl -X POST -H "Content-type: application/json" --data-binary @$f \
       "http://localhost:8983/solr/geoweb/update/json/docs?commit=true"
done
