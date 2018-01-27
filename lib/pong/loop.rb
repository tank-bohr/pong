require 'gosu'

module Pong
  class Loop < Gosu::Window
    def initialize
      width = 700
      height = 500

      @game = Game.new(width: width, height: height)
      @game.start

      super width, height
      self.caption = TITLE
    end

    def update
      @game.update
    end

    def draw
      @game.draw
    end
  end
end
