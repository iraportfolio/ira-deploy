require 'capistrano/rails'

set :rbenv_ruby, fetch(:rbenv_ruby, '2.3.1')
set :rbenv_path, '~/.rbenv'
set :rbenv_ruby_dir, -> { "#{fetch(:rbenv_path)}/versions/#{fetch(:rbenv_ruby)}" }
set :rbenv_map_bins, %w{rake gem bundle ruby rails backup}
set :rbenv_roles, :all
set :deploy_to, "/home/ubuntu/#{fetch(:application)}"
set :domain, 'localhost'

set :linked_files, fetch(:linked_files) << 'config/database.yml'
set :linked_dirs, fetch(:linked_dirs) + %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :bundle_bins, %w{gem rake rails backup}
set :bundle_binstubs, -> { shared_path.join('bin') }
set :migration_role, :db
set :assets_roles, :web
set :assets_prefix, 'assets'

namespace :deploy do
  desc 'Restart application'
  task :restart do
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

  after :finishing, 'deploy:cleanup'
end

before 'deploy:starting', 'shared_files:setup'
after 'deploy:finished', 'nginx:restart'
