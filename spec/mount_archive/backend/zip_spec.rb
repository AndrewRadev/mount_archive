require 'spec_helper'
require 'mount_archive/backend/zip'

module MountArchive
  module Backend
    describe Zip do
      it "knows which files the zipfile contains" do
        zip_archive 'files.zip' do |zip|
          zip.file 'foo.txt'
          zip.file 'bar.dat'
        end

        zip = Zip.new('files.zip')
        zip.files.should eq %w(foo.txt bar.dat)
      end

      it "can extract a file from the zipfile" do
        zip_archive 'file.zip' do |zip|
          zip.file 'foo.txt', 'content'
        end
        zip = Zip.new('file.zip')

        File.exist?('foo.txt').should be_false

        zip.extract('foo.txt')

        File.exist?('foo.txt').should be_true
        IO.read('foo.txt').should eq 'content'
      end
    end
  end
end
