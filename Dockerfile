FROM ruby:2.5.3
RUN apt-get update
RUN apt-get install -y nodejs
RUN gem install bundler -v 1.17.3
EXPOSE 3000

WORKDIR /yamlator
