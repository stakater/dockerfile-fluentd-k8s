FROM stakater/fluentd:0.14.25

ENV ELASTICSEARCH_HOST es-logging.default.svc

RUN apk add --no-cache --virtual .build-deps \
        build-base \
        ruby-dev wget gnupg && \
    gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.26.2 && \
    gem install --no-document fluent-plugin-elasticsearch -v 1.9.5 && \
    gem install --no-document fluent-plugin-prometheus -v 0.2.1 && \
    gem install --no-document fluent-plugin-concat -v 2.1.0 && \
    gem cleanup fluentd && \
    apk del .build-deps

# Remove default conf
RUN rm -f /etc/fluent/*.conf

COPY ./fluent.conf /etc/fluent/