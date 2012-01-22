module Support
  module Integration
    def mount_archive(path)
      system "mount_archive #{path}"

      FileUtils.cd "#{path}.d" do
        yield
      end

      system "umount_archive #{path}.d"
    end
  end
end
