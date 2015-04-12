FROM ruby:2.2.1

MAINTAINER glenn.goodrich@gmail.com

RUN mkdir /app
WORKDIR /app

EXPOSE 5000

CMD ["foreman", "start"]

# Install the necessary gems, remember ADD is not cache
# Friendly 
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install

ADD . /app
