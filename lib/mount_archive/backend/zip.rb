# The Backend::Zip backend is initialized with a filename, corresponding to a
# zip archive. It uses the "unzip" command-line utility to inspect the contents
# of the file.
#
module MountArchive
  module Backend
    class Zip
      def initialize(filename)
        @filename = File.expand_path(filename)
      end

      def files
        %x[ unzip -qql #{@filename} ].each_line.map do |line|
          line.strip.gsub(/^\d+\s*\d+-\d+-\d+\s*\d+:\d+\s*(.*)$/, '\1')
        end
      end

      def extract(path)
        system("unzip -qq #{@filename} #{path}")
      end

      def update(path)
        system("zip -qq #{@filename} #{path}")
      end
    end
  end
end
