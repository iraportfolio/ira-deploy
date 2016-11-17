require 'capistrano/multiconfig'

require 'capistrano/deploy'
require 'capistrano/rbenv'
require 'capistrano/bundler'

# Loads custom tasks
Dir.glob('tasks/*.cap').each { |t| import t }
Dir.glob('helpers/*.rb').each { |h| import h }
