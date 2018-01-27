require 'gosu'

module Pong
  class Player

    SIZE = { width: 10, height: 100 }.freeze
    COLOR = Gosu::Color::WHITE
    DIRECTIONS = { up: -1, down: 1 }.freeze

    attr_reader :game, :position, :velocity

    def initialize(game, position:, velocity:)
      @game = game
      @position = position
      @velocity = velocity
    end

    def catch?(y)
      (position.y < y) && (y < position.y + SIZE[:height])
    end

    def move(direction)
      factor = DIRECTIONS.fetch(direction, 0)
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
