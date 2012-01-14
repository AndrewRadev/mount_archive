require 'fusefs'
require 'fileutils'

module MountArchive
  class Adapter
    def initialize(filename)
      @filename = filename
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
