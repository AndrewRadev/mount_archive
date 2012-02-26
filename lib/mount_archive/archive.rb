require 'set'
require 'pathname'
require 'tmpdir'
require 'fileutils'
require 'mount_archive/backend/zip'

# The Archive class provides an interface to reading and writing an archive's
# contents.
#
# It's initialized with an instance of one of the available backends, which
# handles primitive operations like listing and extracting files (see the
# Backend module for details).
#
module MountArchive
  class Archive
    def initialize(backend)
      @backend   = backend
      @extracted = {}
    end

    def files
      @backend.files
    end

    def extract(path)
      @extracted[path] ||= begin
        new_path = create_temp_path(path)
        FileUtils.cd(temp_dir) { @backend.extract(path) }
        new_path
      end
    end

    private

    def create_temp_path(path)
      temp_path = temp_dir.join(path)
      FileUtils.mkdir_p temp_path.parent if not temp_path.parent.directory?
      temp_path
    end

    def temp_dir
      @temp_dir ||= Pathname.new(Dir.mktmpdir)
    end
  end
end
