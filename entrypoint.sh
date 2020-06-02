#!/bin/sh
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake assets:precompile

if [ -z $SECRET_KEY_BASE ]
then
  export SECRET_KEY_BASE=`bundle exec rake secret`
fi
exec "$@"