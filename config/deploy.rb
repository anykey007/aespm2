#require 'bundler/capistrano'

set :domain, '109.87.78.208'
set :applicationdir, "aespm"

set :scm, 'git'
set :repository,  "git@github.com:anykey007/aespm2.git"
set :git_enable_submodules, 1 # if you have vendored rails
set :branch, 'master'
set :git_shallow_clone, 1
set :scm_verbose, true

# roles (servers)
server "forcus.net", :web, :app, :db, :primary=>true

# deploy config
set :user, 'anykey'
set :use_sudo, false
set :deploy_to, '/var/www/projects/aespm'
set :deploy_via, :remote_cache

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false

# Passenger
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end