server '67.205.147.17', user: 'ubuntu', roles: %w{web app db}

set :branch, 'master'
set :domain, 'sukhomlynova.com'
set :rails_env, 'production'

set :puma_threads, 'threads 1,8'
set :puma_workers, 'workers 1'
