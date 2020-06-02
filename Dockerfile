FROM ruby:2.7.1-alpine3.11

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories \
      && apk add --no-cache build-base postgresql-dev nodejs tzdata # rsync openssh imagemagick

ENV LC_ALL=C.UTF-8 \
    TZ=Asia/Shanghai \
    RAILS_ENV=production \
    APP_DIR=/project
    #HOME_DIR=/root

RUN mkdir $APP_DIR
WORKDIR $APP_DIR

COPY Gemfile Gemfile.lock $APP_DIR/
RUN bundle config set without 'development test' && bundle install
COPY . $APP_DIR
COPY config/database.yml config/database.yml
# RUN mkdir -p tmp/pids

#COPY deploy/id_rsa deploy/id_rsa.pub $HOME_DIR/.ssh/
#RUN chmod 600 $HOME_DIR/.ssh/id_rsa

EXPOSE 3000
COPY entrypoint.sh /usr/bin/entrypoint
RUN chmod +x /usr/bin/entrypoint
ENTRYPOINT ["/usr/bin/entrypoint"]

CMD ["rails", "server", "-b", "0.0.0.0"]