#require 'bundler/capistrano'

set :applicationdir, "aespm"
set :application, "aespm"

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
set :deploy_to, "/var/www/projects/#{application}"
set :deploy_via, :export

# additional settings
default_run_options[:pty] = true  # Forgo errors when deploying from windows
#ssh_options[:keys] = %w(/home/user/.ssh/id_rsa)            # If you are using ssh_keysset :chmod755, "app config db lib public vendor script script/* public/disp*"set :use_sudo, false

set :default_environment, {
  'PATH' => "/usr/share/ruby-rvm/gems/ruby-1.9.2-p290/bin:/usr/share/ruby-rvm/gems/ruby-1.9.2-p290@global/bin:/usr/share/ruby-rvm/rubies/ruby-1.9.2-p290/bin:/usr/share/ruby-rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:"
}

after "deploy", "deploy:bundle_gems"
after "deploy:bundle_gems", "deploy:restart"


# Passenger
namespace :deploy do
  task :bundle_gems do
    run "cd #{deploy_to}/current && bundle install "
  end
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end