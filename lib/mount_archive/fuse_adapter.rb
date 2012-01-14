require 'fusefs'
require 'fileutils'

module MountArchive
  class FuseAdapter
    def initialize(filename)
      @filename = filename
      @dirname  = @filename + '.d'
    end

    def mount
      FuseFS.set_root(self)
      FileUtils.mkdir_p @dirname
      FuseFS.mount_under @dirname
      FuseFS.run
    end

    def contents(path)
      ['hello.txt']
    end

    def file?(path)
      path == '/hello.txt'
    end

    def read_file(path)
      "Hello, World!\n"
    end

    def size(path)
      read_file(path).size
    end
  end
end
