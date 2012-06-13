set :application, "ticketdesk"
set :user, "ubuntu"
set :use_sudo, true
#set :user_sudo, true
set :rvm_ruby_string, 'ruby-1.9.2'

set :scm, 'git'
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "."
#set :local_repository, "file:///Users/alex/Desktop/dev/ticketdesk/.git"
set :branch, "master"
set :deploy_via, 'copy'
set :copy_cache, true
set :scm_verbose, true

set :deploy_to, "/var/www/#{application}"

set :location, "107.20.132.77"

role :web, "107.20.132.77"                         # Your HTTP server, Apache/etc
role :app, "107.20.132.77"                           # This may be the same as your `Web` server
role :db,  "107.20.132.77" , :primary => true # This is where Rails migrations will run
role :db,  "107.20.132.77" 

ssh_options[:user] = "ubuntu"
ssh_options[:keys] = ["/Users/alex/.ssh/ticketdesk.pem"] # make sure you also have the publickey

