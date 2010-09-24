# encoding: utf-8

module CarrierWave
  module Storage

    ##
    # This file serves mostly as a specification for Storage engines. There is no requirement
    # that storage engines must be a subclass of this class.
    #
    class Abstract

      attr_reader :uploader

      def initialize(uploader)
        @uploader = uploader
      end

      def self.setup!
        puts 'not implemented setup!'
      end

      def identifier
        uploader.filename
      end

      def store!(file)
        puts 'not implemented store!'
      end

      def retrieve!(identifier)
        puts 'not implemented retrieve!'
      end

    end # Abstract
  end # Storage
end # CarrierWave
