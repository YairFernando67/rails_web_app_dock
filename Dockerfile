# FROM ruby:2.6.0
# FROM starefossen/ruby-node:latest
# ENV BUNDLER_VERSION=2.1.4


# # RUN curl -sL https://deb.nodesource.com/setup_11.x
# RUN apt-get update -qq && apt-get install -y postgresql-client \
#     git \
#     vim \
#     curl 

# WORKDIR '/app'

# COPY Gemfile .
# RUN gem install rails
# RUN gem update --system && \
#     gem install bundler:2.1.4 && \
#     bundle install

# RUN rails db:seed
# COPY . .

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]


# RUN bundle exec rake assets:precompile
# EXPOSE 3001
# CMD ["rails", "s", "-b", "0.0.0.0"]

FROM ruby:2.6.2-slim
ARG precompileassets

RUN apt-get update && apt-get install -y curl gnupg
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN curl -q https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt-get -y update && \
      apt-get install --fix-missing --no-install-recommends -qq -y \
        build-essential \
        vim \
        wget gnupg \
        git-all \
        curl \
        ssh \
        postgresql-client libpq5 libpq-dev -y && \
      wget -qO- https://deb.nodesource.com/setup_11.x  | bash - && \
      apt-get install -y nodejs && \
      wget -qO- https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
      apt-get update && \
      apt-get install yarn && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN gem install bundler


RUN mkdir /gems
WORKDIR /gems
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install rails
RUN bundle install


ARG INSTALL_PATH=/web_app
ENV INSTALL_PATH $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# RUN chmod u+r+x scripts && chmod +x docker-entrypoint.sh
RUN scripts/asset_precompile.sh $precompileassets

FROM nginx 
COPY --from=0 /web_app /usr/share/nginx/html