class TextBoost < Boost
  validates :text, presence: :true


  def content
    "<h4>#{text}</h4>"
  end

end
