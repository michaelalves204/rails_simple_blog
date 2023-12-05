FROM ruby:3.2.2
RUN apt-get update -y && apt-get install sudo -y

RUN adduser rails_simple_blog
RUN echo "rails_simple_blog ALL=(root) NOPASSWD:ALL" >> /etc/sudoers
RUN sudo apt-get update -y ; sudo apt-get upgrade -y openssl
RUN sudo apt-get install -y unrar-free

USER rails_simple_blog

RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

RUN sudo apt-get install -y nodejs;
RUN sudo apt-get install -y build-essential libpq-dev cmake vim
RUN sudo apt-get update -y && sudo apt-get install postgresql-client-12 -y

ENV DISPLAY :99
ENV RUBY_GC_MALLOC_LIMIT 90000000
ENV RUBY_GC_HEAP_FREE_SLOTS 200000
ENV APP_HOME /rails_simple_blog

RUN sudo mkdir $APP_HOME
WORKDIR $APP_HOME
ADD Gemfile* $APP_HOME/

RUN gem install bundler \
    && bundle install --jobs 3

ADD . $APP_HOME

RUN Xvfb -ac :99 -screen 0 1920x1080x16 &
