FROM solr:8.11

ENV SOLR_HOME /mnt/solr/data
ENV GEO_CORE /var/geoweb

USER root
RUN mkdir -p $SOLR_HOME
RUN chown -R solr:solr $SOLR_HOME

USER $SOLR_UID
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["solr-foreground"]
