FROM goacme/lego
RUN apk --no-cache --no-progress add  curl jq \
    && rm -rf /var/cache/apk/*
COPY *.sh /

VOLUME /.lego
VOLUME /aceme-tmp
ENTRYPOINT ["/entrypoint.sh"]