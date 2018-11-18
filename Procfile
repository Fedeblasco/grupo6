web: bundle exec puma -t 5:5 -p ${PORT:-80} -e ${RACK_ENV:-production}
release: rake db:create & rake db:migrate & rake db:seed
