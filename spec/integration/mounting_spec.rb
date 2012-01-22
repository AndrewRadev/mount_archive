require 'spec_helper'

describe "Mounting" do
  specify "reading a zip file" do
    zip_archive 'test.zip' do |zip|
      zip.file 'foo.txt'
      zip.file 'bar'
    end

    mount_archive 'test.zip' do
      listing = %x[ ls ]
      listing.should include 'foo.txt'
      listing.should include 'bar'
    end
  end
end
