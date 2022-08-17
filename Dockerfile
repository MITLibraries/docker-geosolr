FROM solr:8.11

ENV SOLR_HOME=/mnt/solr/data
ENV GEO_CORE=/mnt/solr/data/geoweb
ENV SOLR_JAVA_MEM=-Xmx1024m
USER root

RUN mkdir -p ${SOLR_HOME}
RUN chown -R solr:solr ${SOLR_HOME}
COPY --chmod=0644 ./solr/solr.xml ${SOLR_HOME}/solr.xml
COPY --chmod=0644 ./solr/security.json ${SOLR_HOME}/security.json

RUN mkdir -p ${GEO_CORE}
COPY ./solr/geoweb/ ${GEO_CORE}/
RUN chown -R solr:solr ${SOLR_HOME}

USER solr
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["solr-foreground"]
