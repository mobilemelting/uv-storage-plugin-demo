# encoding: utf-8
begin
  require 'fog'
rescue LoadError
  raise "You don't have the 'fog' gem installed. The 'aws', 'aws-s3' and 'right_aws' gems are no longer supported."
end

module CarrierWave
  module Storage

    ##
    # Uploads things to Amazon S3 using the "fog" gem.
    # You'll need to specify the access_key_id, secret_access_key and bucket.
    #
    #     CarrierWave.configure do |config|
    #       config.s3_access_key_id = "xxxxxx"
    #       config.s3_secret_access_key = "xxxxxx"
    #       config.s3_bucket = "my_bucket_name"
    #     end
    #
    # You can set the access policy for the uploaded files:
    #
    #     CarrierWave.configure do |config|
    #       config.s3_access_policy = 'public-read'
    #     end
    #
    # The default is 'public-read'. For more options see:
    #
    # http://docs.amazonwebservices.com/AmazonS3/latest/RESTAccessPolicy.html#RESTCannedAccessPolicies
    #
    # For backwards compatability with the original aws-s3 library, if the old +config.s3_access+ is set it
    # will be converted to the appropriate access policy:
    #
    # [:private]              No one else has any access rights.
    # [:public_read]          The anonymous principal is granted READ access.
    #                         If this policy is used on an object, it can be read from a
    #                         browser with no authentication.
    # [:public_read_write]    The anonymous principal is granted READ and WRITE access.
    # [:authenticated_read]   Any principal authenticated as a registered Amazon S3 user
    #                         is granted READ access.
    #
    # You can change the generated url to a cnamed domain by setting the cnamed config:
    #
    #     CarrierWave.configure do |config|
    #       config.s3_cnamed = true
    #       config.s3_bucket = 'bucketname.domain.tld'
    #     end
    #
    # Now the resulting url will be
    #
    #     http://bucketname.domain.tld/path/to/file
    #
    # instead of
    #
    #     http://bucketname.domain.tld.s3.amazonaws.com/path/to/file
    #
    class S3 < Abstract

      class File

        def initialize(uploader, base, path)
          @uploader = uploader
          @path = path
          @base = base
        end

        ##
        # Returns the current path of the file on S3
        #
        # === Returns
        #
        # [String] A path
        #
        def path
          @path
        end

        ##
        # Reads the contents of the file from S3
        #
        # === Returns
        #
        # [String] contents of the file
        #
        def read
          result = connection.get_object(bucket, @path)
          @headers = result.headers
          result.body
        end

        ##
        # Remove the file from Amazon S3
        #
        def delete
          connection.delete_object(bucket, @path)
        end

        ##
        # Returns the url on Amazon's S3 service
        #
        # === Returns
        #
        # [String] file's url
        #
        def url
          if @uploader.s3_cnamed
            ["http://#{@uploader.s3_bucket}", @path].compact.join('/')
          else
            ["http://#{@uploader.s3_bucket}.s3.amazonaws.com", @path].compact.join('/')
          end
        end

        def store(file)
          content_type ||= file.content_type # this might cause problems if content type changes between read and upload (unlikely)
          connection.put_object(bucket, @path, file.read,
            {
              'x-amz-acl' => access_policy,
              'Content-Type' => content_type
            }.merge(@uploader.s3_headers)
          )
        end

        # The Amazon S3 Access policy ready to send in storage request headers.
        def access_policy
          return @access_policy unless @access_policy.blank?
          if @uploader.s3_access_policy.blank?
            if !@uploader.s3_access.blank?
              @access_policy = @uploader.s3_access.to_s.gsub(/_/, '-')
            else
              @access_policy = 'public-read'
            end
          else
            @access_policy = @uploader.s3_access_policy
          end
        end

        def content_type
          headers["Content-Type"]
        end

        def content_type=(type)
          headers["Content-Type"] = type
        end

        def size
         	headers['content-length'].to_i
        end

        # Headers returned from file retrieval
        def headers
          @headers ||= connection.head(bucket, @path)
        end

      private

        def bucket
          @uploader.s3_bucket
        end

        def connection
          @base.connection
        end

      end

      ##
      # Store the file on S3
      #
      # === Parameters
      #
      # [file (CarrierWave::SanitizedFile)] the file to store
      #
      # === Returns
      #
      # [CarrierWave::Storage::S3::File] the stored file
      #
      def store!(file)
        f = CarrierWave::Storage::S3::File.new(uploader, self, uploader.store_path)
        f.store(file)
        f
      end

      # Do something to retrieve the file
      #
      # @param [String] identifier uniquely identifies the file
      #
      # [identifier (String)] uniquely identifies the file
      #
      # === Returns
      #
      # [CarrierWave::Storage::S3::File] the stored file
      #
      def retrieve!(identifier)
        CarrierWave::Storage::S3::File.new(uploader, self, uploader.store_path(identifier))
      end

      def connection
        @connection ||= Fog::AWS::S3.new(
          :aws_access_key_id => uploader.s3_access_key_id,
          :aws_secret_access_key => uploader.s3_secret_access_key
        )
      end

    end # S3
  end # Storage
end # CarrierWave
