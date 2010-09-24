# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  # Include RMagick or ImageScience support
  include CarrierWave::RMagick
  #     include CarrierWave::ImageScience

  # Choose what kind of storage to use for this uploader
  storage :uv_storage

  # Override the directory where uploaded files will be stored
  # This is a sensible default for uploaders that are meant to be mounted:
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
  
  process :resize_to_fit => [800, 800] # Note: process is called before versions are created

  # Create different versions of the uploaded files
  version :size_450 do
  	process :resize_to_fit => [450, 450]
  end

  version :size_400 do
  	process :resize_to_fit => [400, 400]
  end

  version :size_300 do
  	process :resize_to_fit => [300, 300]
  end

  version :size_200 do
  	process :resize_to_fit => [200, 200]
  end

  version :size_150 do
  	process :resize_to_fit => [150, 150]
  end

  version :size_100 do
  	process :resize_to_fit => [100, 100]
  end

  version :size_90 do
  	process :resize_to_fit => [90, 90]
  end

  version :size_80 do
  	process :resize_to_fit => [80, 80]
  end

  version :size_70 do
  	process :resize_to_fit => [70, 70]
  end

  version :size_60 do
  	process :resize_to_fit => [60, 60]
  end

  version :size_50 do
  	process :resize_to_fit => [50, 50]
  end

  version :size_40 do
  	process :resize_to_fit => [40, 40]
  end

  version :size_30 do
  	process :resize_to_fit => [30, 30]
  end

  # Provide a default path as a default if there hasn't been a file uploaded
  #     def default_path
  #       "images/fallback/" + [version_name, "default.png"].compact.join('_')
  #     end

  # Process files as they are uploaded.
  #     process :scale => [200, 300]
  #
  #     def scale(width, height)
  #       # do something
  #     end

  # Create different versions of your uploaded files
  #     version :thumb do
  #       process :scale => [50, 50]
  #     end

  # Add a white list of extensions which are allowed to be uploaded,
  # for images you might use something like this:
  #     def extension_white_list
  #       %w(jpg jpeg gif png)
  #     end

  # Override the filename of the uploaded files
  #     def filename
  #       "something.jpg"
  #     end

end
