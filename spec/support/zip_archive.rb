module Support
  module ZipArchive
    def zip_archive(filename)
      dir = Dir.new
      yield dir
      dir.create_zip_file(filename)
    end

    class Dir
      def initialize
        @files = {}
      end

      def file(name, content = '')
        @files[name] = content
        File.open(name, 'w') { |f| f.write(content) }
      end

      def create_zip_file(filename)
        system "zip -q #{filename} #{@files.keys.join(' ')}"
        @files.keys.each { |filename| File.unlink(filename) }
      end
    end
  end
end
