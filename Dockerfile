# Inspired by https://github.com/lensesio/schema-registry-ui/blob/master/docker/Dockerfile

FROM nginx

WORKDIR /
# Add needed tools
RUN apt update && apt install -y wget dos2unix

# Add and Setup Schema-Registry-Ui
ENV SCHEMA_REGISTRY_UI_VERSION="0.9.5"
RUN wget "https://github.com/Landoop/schema-registry-ui/releases/download/v.${SCHEMA_REGISTRY_UI_VERSION}/schema-registry-ui-${SCHEMA_REGISTRY_UI_VERSION}.tar.gz" \
         -O /tmp/schema-registry-ui.tar.gz \
    && mkdir /usr/share/nginx/html/schema-registry-ui \
    && tar xzf /tmp/schema-registry-ui.tar.gz -C /usr/share/nginx/html/schema-registry-ui --no-same-owner \
    && rm -f /tmp/schema-registry-ui.tar.gz \
    && rm -f /usr/share/nginx/html/schema-registry-ui/env.js \
    && ln -s /tmp/env.js /usr/share/nginx/html/schema-registry-ui/env.js

# Add configuration and runtime files
COPY index.html /usr/share/nginx/html/
COPY schema-registry-ui.conf /etc/nginx/conf.d/default.conf
COPY run.sh /

RUN dos2unix /etc/nginx/conf.d/default.conf && dos2unix /run.sh && chmod +x /run.sh

EXPOSE 80


# USER nobody:nogroup
ENTRYPOINT ["/run.sh"]