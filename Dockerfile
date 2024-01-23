FROM ruby:3.2.1

WORKDIR /app

RUN apt-get update -qq && apt-get install -y nodejs 

COPY Gemfile Gemfile.lock /app/

RUN gem install bundler:2.4.12

RUN bundle install

COPY . /app/

EXPOSE 3000

# CMD ["bin/rails", "server", "-b", "0.0.0.0"]

# rails s -b 0.0.0.0
