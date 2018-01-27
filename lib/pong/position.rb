module Pong
  class Position
    attr_accessor :x, :y

    def initialize(x: 0, y: 0)
      self.x = x
      self.y = y
    end
  end
end
