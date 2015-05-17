class MoneyBoost < Boost
  validates :money, presence: :true


  def content
    "<h4>#{money / 100}$</h4>"
  end

end
