#!/bin/sh


cp -rf $GEO_CORE/* $SOLR_HOME
chown -R solr:solr $SOLR_HOME

exec gosu solr docker-entrypoint.sh "$@"
