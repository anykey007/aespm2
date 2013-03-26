require 'rvm/capistrano'
require 'bundler/capistrano'

set :application, "aespm"
set :rails_env, "production"
set :domain, "travel_club@109.120.166.11"
set :deploy_to, "/srv/#{application}"
set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

# set :rvm_ruby_string, 'ree' # Это указание на то, какой Ruby интерпретатор мы будем использовать.

set :scm, :git # Используем git. Можно, конечно, использовать что-нибудь другое - svn, например, но общая рекомендация для всех кто не использует git - используйте git. 
set :repository,  "git@github.com:anykey007/aespm2.git" # Путь до вашего репозитария. Кстати, забор кода с него происходит уже не от вас, а от сервера, поэтому стоит создать пару rsa ключей на сервере и добавить их в deployment keys в настройках репозитария.
set :branch, "new_features" # Ветка из которой будем тянуть код для деплоя.
set :deploy_via, :remote_cache # Указание на то, что стоит хранить кеш репозитария локально и с каждым деплоем лишь подтягивать произведенные изменения. Очень актуально для больших и тяжелых репозитариев.

role :web, domain
role :app, domain
role :db,  domain, :primary => true

before 'deploy:setup', :roles => :app do
  task :prepare do
    run "mkdir -p /srv/#{application}/releases"
  end
end

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby' # интеграция rvm с capistrano настолько хороша, что при выполнении cap deploy:setup установит себя и указанный в rvm_ruby_string руби.

after 'deploy:update_code', :roles => :app do
  # Здесь для примера вставлен только один конфиг с приватными данными - database.yml. Обычно для таких вещей создают папку /srv/myapp/shared/config и кладут файлы туда. При каждом деплое создаются ссылки на них в нужные места приложения.
  run "rm -f #{current_release}/config/database.yml"
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
end
after 'deploy', 'deploy:cleanup'
# Далее идут правила для перезапуска unicorn. Их стоит просто принять на веру - они работают.
# В случае с Rails 3 приложениями стоит заменять bundle exec unicorn_rails на bundle exec unicorn
namespace :deploy do
  task :symlink_shared do
    # run "ln -nfs #{shared_path}/cached-copy/config/database.yml #{release_path}/config/database.yml"
    # run "ln -nfs #{shared_path}/public/images/uploaded #{release_path}/public/images/uploaded"
  end

  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

namespace :uploaded do
  desc "Create the uploaded dir in shared path."
  task :setup do
    # run "cd #{shared_path}/public/images/;"
    run "mkdir cd #{shared_path}/public/images/galleries"
    run "mkdir cd #{shared_path}/public/images/thumbs"
  end


  desc "Link pictures from shared to common."
  task :symlink do
    puts "\n=== Begin created simlink for images ===\n"
    # run "rm -rf #{current_path}/public/images/;"
    # run "ln -nfs #{shared_path}/public/images/galleries/ #{current_path}/public/images/galleries;"
    # run "ln -nfs #{shared_path}/public/images/thumbs/ #{current_path}/public/images/thumbs;"
    puts "\n=== End created simlink for images ===\n"
    # run "cd #{current_path}/public; rm -rf pictures; ln -s #{shared_path}/pictures ."
  end

end


  namespace :db do
    desc "Create Production Database"
    task :create do
      puts "\n\n=== Creating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:create RAILS_ENV=production"
    end

    desc "Migrate Production Database"
    task :migrate do
      puts "\n\n=== Migrating the Production Database! ===\n\n"
      run "cd #{current_path}; rake db:migrate RAILS_ENV=production"
    end
  end

end


after 'deploy:create_symlink', 'deploy:symlink_shared'