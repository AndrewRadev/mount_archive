require 'fusefs'
require 'fileutils'

require 'mount_archive/archive'

module MountArchive
  class Adapter
    def initialize(filename)
      @filename = filename

      raise "Only zip files supported at this time" if @filename !~ /\.zip$/

      @archive = Archive.new(filename)
    end

    def contents(path)
      @archive.files
    end

    def file?(path)
      @archive.files.include?(path.gsub(/^\//, ''))
    end

    def read_file(path)
      real_path = @archive.extract(path.gsub(/^\//, ''))
      IO.read(real_path)
    end

    def size(path)
      real_path = @archive.extract(path.gsub(/^\//, ''))
      File.size(real_path)
    end
  end
end
