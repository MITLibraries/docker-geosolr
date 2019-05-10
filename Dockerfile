FROM solr:7.7-alpine

ENV SOLR_HOME /var/solr
ENV GEO_CORE /var/geoweb

USER root
COPY solr $GEO_CORE
COPY entrypoint.sh /usr/local/bin/
RUN mkdir -p $SOLR_HOME
RUN chown -R solr:solr $GEO_CORE $SOLR_HOME /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["solr-foreground"]
