
# README
Follow the following steps to run the project:

1) The database in postgres.
Installation instructions for macOS here:
https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-macos

2) After you have the database up and running, run the following on terminal to create a db role

`createuser -P -d homeapp`

3) At the password prompt use this as password:

`homeapp`

4) Clone the project

`git clone git@github.com:vivekvermaiit/home-improvement-project.git`

5) Move to project directory and run migrations

`rails db:create db:migrate`

6) start server

`rails server`

Should be up and running at
http://localhost:3000/

## To run the tests

1) Run migrations

`rake db:drop db:create db:migrate RAILS_ENV="test"`

2) Run Rspec tests

`bundle exec rake spec`
