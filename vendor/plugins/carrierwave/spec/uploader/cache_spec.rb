# encoding: utf-8

require File.dirname(__FILE__) + '/../spec_helper'

describe CarrierWave::Uploader do

  before do
    @uploader_class = Class.new(CarrierWave::Uploader::Base)
    @uploader = @uploader_class.new
  end
  
  after do
    FileUtils.rm_rf(public_path)
  end

  describe '#cache_dir' do
    it "should default to the config option" do
      @uploader.cache_dir.should == 'uploads/tmp'
    end
  end

  describe '#cache!' do

    before do
      CarrierWave.stub!(:generate_cache_id).and_return('20071201-1234-345-2255')
    end

    it "should cache a file" do
      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.file.should be_an_instance_of(CarrierWave::SanitizedFile)
    end

    it "should be cached" do
      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.should be_cached
    end

    it "should store the cache name" do
      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.cache_name.should == '20071201-1234-345-2255/test.jpg'
    end

    it "should set the filename to the file's sanitized filename" do
      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.filename.should == 'test.jpg'
    end

    it "should move it to the tmp dir" do
      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.file.path.should == public_path('uploads/tmp/20071201-1234-345-2255/test.jpg')
      @uploader.file.exists?.should be_true
    end

    it "should not move it if cache_to_cache_dir is false" do
      CarrierWave.config[:cache_to_cache_dir] = false
      path = file_path('test.jpg')
      @uploader.cache!(File.open(path))
      @uploader.current_path.should == path
      @uploader.file.exists?.should be_true
      CarrierWave.config[:cache_to_cache_dir] = true
    end

    it "should set the url" do
      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.url.should == '/uploads/tmp/20071201-1234-345-2255/test.jpg'
    end

    it "should raise an error when trying to cache a string" do
      running {
        @uploader.cache!(file_path('test.jpg'))
      }.should raise_error(CarrierWave::FormNotMultipart)
    end

    it "should raise an error when trying to cache a pathname" do
      running {
        @uploader.cache!(Pathname.new(file_path('test.jpg')))
      }.should raise_error(CarrierWave::FormNotMultipart)
    end

    it "should do nothing when trying to cache an empty file" do
      @uploader.cache!(nil)
    end

    it "should set permissions if options are given" do
      old_permissions = CarrierWave.config[:permissions]
      CarrierWave.config[:permissions] = 0777

      @uploader.cache!(File.open(file_path('test.jpg')))
      @uploader.should have_permissions(0777)

      CarrierWave.config[:permissions] = old_permissions
    end
  end

  describe '#retrieve_from_cache!' do
    it "should cache a file" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.file.should be_an_instance_of(CarrierWave::SanitizedFile)
    end

    it "should be cached" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.should be_cached
    end

    it "should set the path to the tmp dir" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.current_path.should == public_path('uploads/tmp/20071201-1234-345-2255/test.jpeg')
    end

    it "should overwrite a file that has already been cached" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/bork.txt')
      @uploader.current_path.should == public_path('uploads/tmp/20071201-1234-345-2255/bork.txt')
    end

    it "should store the cache_name" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.cache_name.should == '20071201-1234-345-2255/test.jpeg'
    end

    it "should store the filename" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.filename.should == 'test.jpeg'
    end

    it "should set the url" do
      @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpeg')
      @uploader.url.should == '/uploads/tmp/20071201-1234-345-2255/test.jpeg'
    end

    it "should raise an error when the cache_id has an invalid format" do
      running {
        @uploader.retrieve_from_cache!('12345/test.jpeg')
      }.should raise_error(CarrierWave::InvalidParameter)

      @uploader.file.should be_nil
      @uploader.filename.should be_nil
      @uploader.cache_name.should be_nil
    end

    it "should raise an error when the original_filename contains invalid characters" do
      running {
        @uploader.retrieve_from_cache!('20071201-1234-345-2255/te/st.jpeg')
      }.should raise_error(CarrierWave::InvalidParameter)
      running {
        @uploader.retrieve_from_cache!('20071201-1234-345-2255/te??%st.jpeg')
      }.should raise_error(CarrierWave::InvalidParameter)

      @uploader.file.should be_nil
      @uploader.filename.should be_nil
      @uploader.cache_name.should be_nil
    end
  end

  describe 'with an overridden, reversing, filename' do
    before do
      @uploader_class.class_eval do
        def filename
          super.reverse unless super.blank?
        end
      end
    end

    describe '#cache!' do

      before do
        CarrierWave.stub!(:generate_cache_id).and_return('20071201-1234-345-2255')
      end

      it "should set the filename to the file's reversed filename" do
        @uploader.cache!(File.open(file_path('test.jpg')))
        @uploader.filename.should == "gpj.tset"
      end

      it "should move it to the tmp dir with the filename unreversed" do
        @uploader.cache!(File.open(file_path('test.jpg')))
        @uploader.current_path.should == public_path('uploads/tmp/20071201-1234-345-2255/test.jpg')
        @uploader.file.exists?.should be_true
      end
    end

    describe '#retrieve_from_cache!' do
      it "should set the path to the tmp dir" do
        @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpg')
        @uploader.current_path.should == public_path('uploads/tmp/20071201-1234-345-2255/test.jpg')
      end

      it "should set the filename to the reversed name of the file" do
        @uploader.retrieve_from_cache!('20071201-1234-345-2255/test.jpg')
        @uploader.filename.should == "gpj.tset"
      end
    end
  end

end