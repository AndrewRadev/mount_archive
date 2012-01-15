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
    end
  end
end
