FROM solr:8.11

# Since we are starting with the official Solr container, most of the 
# environment variables are already set. The following just makes some
# MIT Libraries specific customizations for the GIS Services stack (e.g., geoweb).

# A location in the container to temporarily store the geoweb-related
# content when the container is built (during the container launch, this
# is copied to $GEOWEB_HOME)
ARG GEO_CORE=/opt/solr/server/geoweb
ARG SOLR_CORE=/opt/solr/server/solr

# Set a default SOLR_JAVA_MEM to 1G, but will be overwritten by an ECS task
# definition environement variable in production.
ENV SOLR_JAVA_MEM=-Xmx1024m
ENV GEOWEB_HOME=/var/solr/data/geoweb

# Copy our custom solr.xml to the source directory for the container launch
USER root
COPY --chmod=0644 ./solr/solr.xml ${SOLR_CORE}/solr.xml

# Modify the Solr launch script to include a step to build the geoweb core
COPY --chmod=0775 ./solr-foreground /opt/docker-solr/scripts/solr-foreground

# Copy our initial geoweb core to the source directory for the container launch
RUN mkdir -p ${GEO_CORE}
COPY ./solr/geoweb/ ${GEO_CORE}/

# This is the same User, Entrypoint, and Cmd as the source container
USER solr
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["solr-foreground"]
