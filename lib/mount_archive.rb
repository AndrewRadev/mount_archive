require 'fusefs'
require 'mount_archive/adapter'

module MountArchive
  def self.mount(filename)
    adapter = Adapter.new(filename)
    dirname = filename + '.d'

    FuseFS.set_root(adapter)
    FileUtils.mkdir_p dirname
    FuseFS.mount_under dirname
    FuseFS.run
  end
end
