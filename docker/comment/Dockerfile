#FROM ruby:2.4
#RUN apt-get update -qq && apt-get install -y build-essential
#RUN apt-get update -qq && apt-get install -y build-essential --no-install-recommends && rm -rf /var/lib/apt/lists/*

FROM ubuntu:16.04
RUN apt-get update \
    && apt-get install -y ruby-full ruby-dev build-essential \
    && gem install bundler -v 2.3.26 --no-ri --no-rdoc && rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

ADD Gemfile* $APP_HOME/
#COPY Gemfile* $APP_HOME/
RUN bundle install
ADD . $APP_HOME
#COPY . $APP_HOME

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
