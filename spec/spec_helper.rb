require 'pp'
require 'simplecov'
require 'pry'

TEST_DIR = File.expand_path(File.dirname(__FILE__) + '/../tmp')
Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |file| require file }
ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../bin')}:#{ENV['PATH']}"

include Support::ZipArchive

RSpec.configure do |config|
  config.before do
    @_root_dir = FileUtils.getwd
    FileUtils.rm_r TEST_DIR if File.directory?(TEST_DIR)
    FileUtils.mkdir TEST_DIR
    FileUtils.cd TEST_DIR
  end

  config.after do
    FileUtils.cd @_root_dir
  end
end

SimpleCov.start
