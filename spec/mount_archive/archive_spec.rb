require 'spec_helper'
require 'mount_archive/archive'

module MountArchive
  describe Archive do
    let(:backend) { TestBackend.new }
    let(:archive) { Archive.new(backend) }

    it "knows what the archive's files are" do
      backend.data = { 'one' => 'foo', 'two' => 'bar' }
      archive.files.should eq %w(one two)
    end

    it "can extract a file to a temporary path and return the extracted path" do
      backend.data = { 'foo.txt' => 'bar' }
      path = archive.extract('foo.txt')
      IO.read(path).should eq 'bar'
    end
  end
end
