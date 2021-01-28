FROM ruby:2.7.0

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN mkdir /ror-social-scaffold
WORKDIR /ror-social-scaffold

COPY Gemfile /ror-social-scaffold/Gemfile
COPY Gemfile.lock /ror-social-scaffold/Gemfile.lock

RUN bundle install

COPY . /ror-social-scaffold