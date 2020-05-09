FROM letfn/container AS download

ARG _CLOUDFLARED_VERSION=2020.5.0

WORKDIR /tmp

RUN curl -sSL -O https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-v${_CLOUDFLARED_VERSION}-linux-amd64.tgz \
    && tar xvfz cloudflared-v${_CLOUDFLARED_VERSION}-linux-amd64.tgz \
    && rm -f cloudflared-v${_CLOUDFLARED_VERSION}-linux-amd64.tgz \
    && chmod 755 cloudflared

FROM letfn/python

COPY --chown=app:app requirements.txt /app/src/
RUN . /app/venv/bin/activate && pip install --no-cache-dir -r /app/src/requirements.txt
COPY --chown=app:app src /app/src

COPY --from=download /tmp/cloudflared /usr/local/bin/cloudflared

COPY service /service

ENTRYPOINT [ "/tini", "--", "/service" ]
CMD [ "tunnel" ]