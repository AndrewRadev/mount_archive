require 'fusefs'
require 'fileutils'

require 'mount_archive/archive'

module MountArchive
  class Adapter
    def initialize(filename)
      @filename = filename

      raise "Only zip files supported at this time" if @filename !~ /\.zip$/

      backend  = Backend::Zip.new(filename)
      @archive = Archive.new(backend)
    end

    def contents(path)
      @archive.files
    end

    def file?(path)
      @archive.files.include?(path.gsub(/^\//, ''))
    end

    def can_write?(path)
      true
    end

    def can_delete?(path)
      true
    end

    def can_execute?(path)
      true
    end

    def read_file(path)
      real_path = @archive.extract(path.gsub(/^\//, ''))
      IO.read(real_path)
    end

    def write_to(path, content)
      path      = path.gsub(/^\//, '')
      real_path = @archive.extract(path)

      File.open(real_path, 'wb') { |f| f.write(content) }
      @archive.update(path)
    end

    def size(path)
      real_path = @archive.extract(path.gsub(/^\//, ''))
      File.size(real_path)
    end
  end
end
