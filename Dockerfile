FROM elixir:1.7.4-alpine
ENV LANG C.UTF-8

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main/ >> /etc/apk/repositories && \
  apk -U upgrade && \
  apk --update --no-cache add ncurses-libs git wget ca-certificates openssl nodejs curl make gcc g++ python npm yarn && \
  update-ca-certificates --fresh && \
  rm -rf /tmp/* /var/cache/apk/* && \
  mix local.rebar --force && \
  mix local.hex --force && \
  mix hex.info && \
  mix archive.install --force hex phx_new 1.4.0 && \
  wget https://github.com/bryanstearns/mix_deps_add/releases/download/0.1.3/mix_deps_add-0.1.3.ez && \
  mix archive.install mix_deps_add-0.1.3.ez --force

EXPOSE 4000

CMD ["ash"]

WORKDIR /app
