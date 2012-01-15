require 'set'
require 'pathname'
require 'tmpdir'
require 'fileutils'
require 'mount_archive/backend/zip'

# The Archive class provides an interface to reading and writing an archive's
# contents.
#
# It's initialized with the archive's filename, and based on that, uses one of
# the available backends to handle primitive operations like listing and
# extracting files (see the Backend module for details).
#
module MountArchive
  class Archive
    def initialize(filename)
      @backend = Backend::Zip.new(filename)
    end

    def files
      @backend.files
    end

    def extract(path)
      @extracted ||= Set.new
      return if @extracted.include? path

      temporary_path = tempdir.join(path)
      FileUtils.mkdir_p temporary_path.parent if not temporary_path.parent.directory?

      in_dir(tempdir) { @backend.extract(path) }
      @extracted.add(path)

      temporary_path
    end

    private

    def tempdir
      @tempdir ||= Pathname.new(Dir.mktmpdir)
    end

    def in_dir(dir)
      original_dir = FileUtils.getwd
      FileUtils.cd dir
      yield
      FileUtils.cd original_dir
    end
  end
end
