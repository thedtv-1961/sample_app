class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_limit: [Settings.minimagick_width,
                            Settings.minimagick_height]
  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end
  #
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def public_id
    return model.short_name
  end
end
