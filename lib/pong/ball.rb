module Pong
  class Ball

    SIZE = { width: 10, height: 10 }.freeze
    COLOR = Gosu::Color::WHITE

    attr_accessor :game, :position, :velocity, :direction

    def initialize(game, position:, direction:, velocity:)
      @game = game
      @position = position
      @velocity = velocity
      @direction = direction
    end

    def move
      collision = game.ball_collision(position)

      case collision
      when :vertical
        direction.y = -direction.y
      when :horizontal
        direction.x = -direction.x
      end

      self.position = Position.new(
        x: position.x + direction.x * velocity,
        y: position.y + direction.y * velocity
      )
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
