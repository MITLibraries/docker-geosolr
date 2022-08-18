FROM solr:8.11

ARG GEO_CORE=/var/geoweb

ENV SOLR_JAVA_MEM=-Xmx1024m
ENV GEOWEB_HOME=/var/solr/data/geoweb

USER root

COPY --chmod=0644 ./solr/solr.xml ${SOLR_HOME}/solr.xml
COPY --chmod=0775 ./solr-foreground /opt/docker-solr/scripts/solr-foreground
# COPY --chmod=0644 ./solr/security.json ${SOLR_HOME}/security.json

RUN mkdir -p ${GEO_CORE}
COPY ./solr/geoweb/ ${GEO_CORE}/
RUN chown -R solr:solr ${GEO_CORE}

USER solr
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["solr-foreground"]
