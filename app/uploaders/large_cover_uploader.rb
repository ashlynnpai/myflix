class LargeCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  
  def extension_white_list
    %w(jpg jpeg gif png)
  end

  process :resize_to_fill => [665, 375] 
end