require 'gosu'

module Pong
  class Player

    SIZE = { width: 10, height: 50 }
    COLOR = Gosu::Color::WHITE
    FACTORS = { up: -1, down: 1 }

    attr_reader :game, :position, :velocity

    def initialize(game, position:, velocity:)
      @game = game
      @position = position
      @velocity = velocity
    end

    def move(direction)
      factor = FACTORS.fetch(direction, 0)
      dy = factor * velocity
      new_y = position.y + dy
      if game.fits_y?(new_y)
        @position.y = new_y
      end
    end

    def draw
      Gosu.draw_rect(
        position.x,
        position.y,
        SIZE[:width],
        SIZE[:height],
        COLOR
      )
    end
  end
end
