Database -> Postgresql
Rails Version -> 7.0.8
Ruby Version -> 3.0.6

 background Job -> Sidekiq

 Commands for running the application - 
 1. sudo service redis-server start
 2. bundle exec sidekiq
 3. rails s

In seed file admin and User are created  -> rails db:seed
In config/database.yml, change the username and password for database