require 'spec_helper'
require 'mount_archive/fuse_adapter'

module MountArchive
  describe FuseAdapter do
    let(:adapter) { MountArchive::FuseAdapter.new('stub') }

    it "contains a single file named 'hello.txt'" do
      adapter.contents('anything').should eq ['hello.txt']
    end

    it "only validates the existence of the file 'hello.txt'" do
      adapter.should be_file('/hello.txt')
      adapter.should_not be_file('/foo.txt')
    end

    it "can read the content of 'hello.txt', and it's 'Hello, World!'" do
      adapter.read_file('/hello.txt').should eq "Hello, World!\n"
    end

    it "can check the size of a file" do
      adapter.size('/hello.txt').should eq "Hello, World!\n".size
    end
  end
end
