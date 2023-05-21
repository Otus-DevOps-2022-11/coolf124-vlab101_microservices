FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN gem install bundler -v 2.3.26
#RUN git clone -b monolith https://github.com/express42/reddit.git

COPY ./mongod.conf /etc/mongod.conf
#COPY db_config /reddit/db_config
ADD . /reddit/
COPY ./start.sh /start.sh
#COPY simpletest.rb /reddit/simpletest.rb
#COPY Gemfile /reddit/Gemfile

RUN cd /reddit && rm Gemfile.lock && bundle install
RUN chmod 0777 /start.sh

CMD ["/start.sh"]
