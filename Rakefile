require 'bundler'
Bundler::GemHelper.install_tasks

task(:flog) { sh 'flog lib' }
task(:flay) { sh 'flay lib' }

task :console do
  sh 'pry -Ilib -r mount_archive'
end
