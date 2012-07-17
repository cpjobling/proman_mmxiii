require 'bundler/capistrano'

set :rvm_ruby_string, '1.9.3@proman2013'
require 'rvm/capistrano'

set :application, "proman"
set :scm, :git
set :repository,  "git://github.com/cpjobling/proman_mmxxiii"

server "eng-hope.swan.ac.uk", :web, :app, :db, :primary => true

ssh_options[:keys] = "~/.ssh/public_key"

set :user, "passenger"
set :group, "passenger"
set :deploy_to, "/home/passenger/proman.swan.ac.uk"
set :use_sudo, false

set :deploy_via, :copy
set :copy_strategy, :export

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   desc "Restart the application"
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
   end
   desc "Copy the mongoid.yml file into the latest release"
   task :copy_in_mongoid_yaml do
    run "cp #{shared_path}/config/mongoid.yml #{latest_release}/config/"
  end
end
before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

namespace :rvm do
  desc 'Trust rvmrc file'
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

after "deploy:update_code", "rvm:trust_rvmrc"

before "deploy:assets:precompile", "deploy:copy_in_mongoid_yaml"
