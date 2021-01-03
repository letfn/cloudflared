FROM letfn/container AS download

ARG _CLOUDFLARED_VERSION=2020.11.11

WORKDIR /tmp

RUN curl -sSL -O https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-v${_CLOUDFLARED_VERSION}-linux-amd64.tgz \
    && tar xvfz cloudflared-v${_CLOUDFLARED_VERSION}-linux-amd64.tgz \
    && rm -f cloudflared-v${_CLOUDFLARED_VERSION}-linux-amd64.tgz \
    && chmod 755 cloudflared

FROM defn/python

COPY --from=download /tmp/cloudflared /usr/local/bin/cloudflared

COPY service /service

ENTRYPOINT [ "/tini", "--", "/service" ]
CMD [ "tunnel" ]
