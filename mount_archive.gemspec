require File.expand_path('../lib/mount_archive/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'mount_archive'
  s.version     = MountArchive::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Andrew Radev']
  s.email       = ['andrey.radev@gmail.com']
  s.homepage    = 'http://github.com/AndrewRadev/mount_archive'
  s.summary     = 'Mount an archive as a virtual filesystem'
  s.description = <<-D
    Mounts various kinds of archives onto a filesystem for transparent
    exploration and modification of the archive's contents.
  D

  s.add_dependency 'fusefs'
  s.add_dependency 'dante'

  s.add_development_dependency 'rspec', '>= 2.0.0'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'flog'
  s.add_development_dependency 'flay'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'mount_archive'

  s.files        = Dir['{lib}/**/*.rb', 'bin/*', 'LICENSE', '*.md']
  s.require_path = 'lib'
  s.executables  = ['mount_archive']
end
