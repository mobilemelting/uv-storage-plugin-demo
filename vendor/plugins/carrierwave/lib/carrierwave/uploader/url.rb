# encoding: utf-8

module CarrierWave
  module Uploader
    module Url

      ##
      # === Returns
      #
      # [String] the location where this file is accessible via a url
      #
      def url
        puts 'Getting URL'
        
        storage.retrieve!(identifier)
        
        if file.respond_to?(:url) and not file.url.blank?
          puts 'from FILE'
          return file.url
        elsif current_path
          puts 'from PUBLIC'
          return File.expand_path(current_path).gsub(File.expand_path(public), '')
        end
      end

      alias_method :to_s, :url

    end # Url
  end # Uploader
end # CarrierWave