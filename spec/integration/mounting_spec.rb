require 'spec_helper'

describe "Mounting" do
  specify "reading a zip file" do
    zip_archive 'test.zip' do |zip|
      zip.file 'foo.txt'
      zip.file 'bar'
    end

    system 'mount_archive test.zip'
    FileUtils.cd 'test.zip.d' do
      listing = %x[ ls ]
      listing.should include 'foo.txt'
      listing.should include 'bar'
    end
    system 'umount_archive test.zip.d'
  end
end
