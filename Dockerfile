FROM ubuntu:xenial
# Add the RethinkDB repository and public key
# "RethinkDB Packaging <packaging@rethinkdb.com>" http://download.rethinkdb.com/apt/pubkey.gpg

RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 3B87619DF812A63A8C1005C30742918E5C8DA04A
RUN echo "deb http://download.rethinkdb.com/apt xenial main" > /etc/apt/sources.list.d/rethinkdb.list

ENV RETHINKDB_PACKAGE_VERSION 2.3.6~0xenial

RUN apt-get update --fix-missing \
  && apt-get -y install python-pip \
  && apt-get install -y rethinkdb=$RETHINKDB_PACKAGE_VERSION \
  && rm -rf /var/lib/apt/lists/* \
  && sudo pip install rethinkdb==2.3.0.post6\
  && mkdir /backups \
  && mkdir /scripts

ENV CRON_TIME="0 0 * * *"

ADD run.sh /run.sh

VOLUME ["/backups"]

CMD ["/run.sh"]
