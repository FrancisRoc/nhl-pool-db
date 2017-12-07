# The version is the same as RDS, update only if it's updated in prod
FROM postgres:9.6.1-alpine

################################################################################################
###
### Install RUBY
### From: https://github.com/cybercode/alpine-ruby
###
RUN apk update && apk upgrade && apk --update add \
    ruby ruby-irb ruby-rake ruby-io-console ruby-bigdecimal ruby-json ruby-bundler git \
    libstdc++ tzdata bash ca-certificates \
    &&  echo 'gem: --no-document' > /etc/gemrc

################################################################################################
###
### Install Schema-evolution-manager
### Ref: https://github.com/mbryzek/schema-evolution-manager
###
RUN mkdir -p /db/data && chown postgres:postgres /db/data
COPY scripts /db/scripts
COPY apply.sh db
WORKDIR /db
RUN gem install schema-evolution-manager


################################################################################################
###
### Configure Postgres so that it runs our init script to create dev and test db.
###
ENV POSTGRES_USER=dev
ENV POSTGRES_PASSWORD=devpass
ENV POSTGRES_DB=dev

COPY init-db.sh /docker-entrypoint-initdb.d/
RUN chmod 755 /docker-entrypoint-initdb.d/init-db.sh 