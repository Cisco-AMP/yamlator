FROM ruby:2.5.3
ADD . /yamlator
WORKDIR /yamlator
RUN apt-get update
RUN apt-get install -y nodejs
RUN gem install bundler -v 1.17.3
COPY . /yamlator
RUN bundle install
EXPOSE 3000
CMD bin/rails s -b 0.0.0.0
