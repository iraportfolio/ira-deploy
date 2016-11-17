set :application, fetch(:stage).split(':').reverse[1]
set :app_namespace, fetch(:application)
set :app_stage, fetch(:stage).split(':')[1]
set :stage, fetch(:app_stage)
set :app_folder, File.expand_path("../deploy/#{fetch(:app_namespace)}", __FILE__)

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, true
set :keep_releases, 5
set :domain, fetch(:domain)
set :ssh_options, forward_agent: true
set :use_sudo, false

set :linked_files, %w{config/puma.rb .env}
set :linked_dirs, []

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }

if ENV['BRANCH'].nil? || ENV['BRANCH'].empty?
  set :branch, 'master'
else
  set :branch, ENV['BRANCH']
end
