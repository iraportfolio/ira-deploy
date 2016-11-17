require File.expand_path('../../rails.rb', __FILE__)

set :application, 'portfolio'
set :repo_url, 'git@github.com:iraportfolio/portfolio.git'

set :rbenv_ruby, '2.3.1'
set :linked_dirs, fetch(:linked_dirs) << 'public/uploads'

after 'deploy:finished', 'foreman:export'
after 'deploy:finished', 'foreman:restart'
