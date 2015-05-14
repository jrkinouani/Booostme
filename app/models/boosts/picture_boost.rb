class PictureBoost < Boost
  validates :image, presence: :true

  def content
    "<img alt=\"boost_image\" src=\"#{image.thumb.url}\" />"
  end

end
