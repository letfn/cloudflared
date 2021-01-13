
FROM defn/python

ARG _CLOUDFLARED_VERSION=2020.11.11

RUN curl -sSL https://pkg.cloudflare.com/pubkey.gpg | sudo apt-key add -
RUN echo 'deb http://pkg.cloudflare.com/ focal main' | sudo tee /etc/apt/sources.list.d/cloudflare-main.list
RUN sudo apt-get update && sudo apt-get install -y cloudflared=${_CLOUDFLARED_VERSION}

COPY service /service

ENTRYPOINT [ "/tini", "--", "/service" ]
CMD [ "tunnel" ]
