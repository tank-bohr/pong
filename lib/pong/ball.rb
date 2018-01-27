module Pong
  class Ball

    SIZE = { width: 10, height: 10 }
    COLOR = Gosu::Color::WHITE

    attr_accessor :position, :velocity, :direction

    def initialize(position:, direction:, velocity_factor:)
      @position = position
      @velocity_factor = velocity_factor
      @velocity = 0 * velocity_factor
      @direction = direction
    end

    def move
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
