class TextBoost < Boost
  validates :text, presence: :true


  def content
    text
  end

end
