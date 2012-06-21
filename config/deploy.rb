set :rvm_ruby_string, 'ruby-1.9.3-p194@proman_2013'
require "rvm/capistrano"
require "bundler/capsitrano"

set :application, "Proman 2013"
set :repository,  "https://github.com/cpjobling/proman_mmxxiii.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "proman.swan.ac.uk"                          # Your HTTP server, Apache/etc
role :app, "proman.swan.ac.uk"                          # This may be the same as your `Web` server
role :db,  "proman.swan.ac.uk", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

set :user, "passenger"
set :scm_username, "cpjobling"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
