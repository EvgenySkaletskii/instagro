require "image_processing/mini_magick"

class AvatarUploader < Shrine
  Attacher.validate do
    validate_max_size 5 * 1024 * 1024, message: "is too large (max is 5 MB)"
    validate_mime_type %w[image/jpeg image/png image/gif]
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)

    {
      large: magick.resize_to_limit!(800, 800),
      medium: magick.resize_to_limit!(200, 200),
      small: magick.resize_to_limit!(50, 50),
    }
  end
end
