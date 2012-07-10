class CoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  def store_dir
    "uploads/album/cover/#{model.id}"
  end

  def default_url
    "/images/album_placeholders/#{version_name}.gif"
  end

  def filename
    'cover.jpg' if original_filename
  end

  version :large do
    process resize_to_fill: [300, 300]
  end

  version :small do
    process resize_to_fill: [100, 100]
  end
end
