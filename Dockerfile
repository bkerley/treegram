FROM ruby:2.5.0

RUN apt-get update -qq && \
  apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /miamigram
WORKDIR /miamigram
ADD Gemfile* /miamigram/
RUN bundle install
ADD . /miamigram
