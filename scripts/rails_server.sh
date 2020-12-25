#! /bin/bash

rails db:create 
rails db:migrate RAILS_ENV=development
bundle exec rails s -b 0.0.0.0