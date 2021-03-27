FROM ruby:3.0.0
WORKDIR /app
COPY Gemfile /app/Gemfile
RUN bundle install
COPY Gemfile.lock /app/Gemfile.lock
COPY . /app

EXPOSE 4567

CMD ["bundle", "exec", "ruby", "server.rb", "-o", "0.0.0.0"]
