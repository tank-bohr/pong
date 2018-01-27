require 'aasm'
require 'pong/player'
require 'pong/position'
require 'pong/ball'

module Pong
  class Game
    include AASM

    aasm do
      state :idle, initial: true
      state :playing, :won, :loss

      event :start, before: :bootstrap do
        transitions from: :idle, to: :playing
      end

      event :win do
        transitions from: :playing, to: :won
      end

      event :loose do
        transitions from: :playing, to: :loss
      end
    end

    attr_reader :width, :height, :state
    attr_reader :beep, :pickup_coin
    attr_reader :player_left, :player_right, :ball

    def initialize(width:, height:)
      @width = width
      @height = height

      @beep = Gosu::Sample.new("media/beep.wav")
      @pickup_coin = Gosu::Sample.new("media/pickup_coin.wav")
    end

    def bootstrap
      player_y = height / 2 - Player::SIZE[:height] / 2

      left_player_position = Position.new(
        x: 0,
        y: player_y
      )

      right_player_position = Position.new(
        x: width - Player::SIZE[:width],
        y: player_y
      )

      ball_position = Position.new(
        x: width / 2 - Ball::SIZE[:width] / 2,
        y: height / 2 - Ball::SIZE[:height] / 2
      )
      velocity = 10
      @player_left = Player.new(self, position: left_player_position, velocity: velocity)
      @player_right = Player.new(self, position: right_player_position, velocity: velocity)
      @ball = Ball.new(
        self,
        position: ball_position,
        # FIXME: randomize direction
        direction: Position.new(x: 1, y: 1),
        velocity: 2
      )
    end

    def update
      direction = get_direction

      player_left.move(direction)
      player_right.move(direction)

      ball.move
    end

    def draw
      player_left.draw
      player_right.draw
      ball.draw
    end

    def get_direction
      if Gosu.button_down? Gosu::KB_UP
        :up
      elsif Gosu.button_down? Gosu::KB_DOWN
        :down
      end
    end

    def fits_y?(y)
      (0 < y) && (y < height - Player::SIZE[:height])
    end

    def ball_collision(position)
      if (0 > position.y) || (position.y > height - Ball::SIZE[:height])
        pickup_coin.play
        :vertical
      elsif left_player_collision?(position) || right_player_collision?(position)
        beep.play
        :horizontal
      elsif out?(position)
        # Gosu::Sample.new("media/explosion.wav").play
        exit
      end
    end

    def left_player_collision?(position)
      (Player::SIZE[:width] >= position.x) && player_left.catch?(position.y)
    end

    def right_player_collision?(position)
      (width - Player::SIZE[:width] <= position.x + Ball::SIZE[:width]) \
        && player_right.catch?(position.y)
    end

    def out?(position)
      (position.x < 0) || (position.x > width)
    end
  end
end
