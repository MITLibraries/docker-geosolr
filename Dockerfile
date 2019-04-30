FROM solr:7.7-alpine

COPY solr /var/solr
USER root
RUN chown -R solr:solr /var/solr
USER solr
