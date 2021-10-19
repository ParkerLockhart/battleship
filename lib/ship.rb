class Ship
  attr_accessor :name, :length

  def initialize(name,length)
    @name = name
    @length = length
  end

  def health
    @length
  end




end
