#! /bin/bash

rails db:create RAILS_ENV=test
rails db:migrate RAILS_ENV=test
bundle exec rspec