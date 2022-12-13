# syntax=docker/dockerfile:1
FROM ruby:2.6.7
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /myapp
COPY . /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler:2.2.21
RUN bundle install

#Add a script to be executed every time the conatiner starts.
COPY initial-setup.sh /usr/bin/
RUN chmod +x /usr/bin/initial-setup.sh
ENTRYPOINT ["initial-setup.sh"]
EXPOSE 3000

#Configure the main process to run when running the image
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb","-p","3000"]
