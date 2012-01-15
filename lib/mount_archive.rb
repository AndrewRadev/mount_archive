require 'fusefs'
require 'mount_archive/adapter'
require 'mount_archive/archive'
require 'mount_archive/backend/zip'

module MountArchive
  def self.mount(filename)
    adapter = Adapter.new(filename)
    dirname = filename + '.d'

    trap 'INT' do
      puts
      puts 'Unmounting...'
      unmount(dirname)
      exit
    end

    FuseFS.set_root(adapter)
    FileUtils.mkdir_p dirname
    FuseFS.mount_under dirname
    FuseFS.run
  end

  def self.unmount(dir)
    system "fusermount -u #{dir} && rmdir #{dir}"
  end
end
