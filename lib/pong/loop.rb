require 'gosu'

module Pong
  class Loop < Gosu::Window
    def initialize
      width = 700
      height = 500

      game = Game.new(width: width, height: height)

      super width, height
      self.caption = TITLE
    end

    def update
    end

    def draw
    end
  end
end
