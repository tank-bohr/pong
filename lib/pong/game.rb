require 'aasm'

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

    attr_reader :width, :height, :state, :player_left, :player_right

    def initialize(width:, height:)
      @width = width
      @height = height
    end

    def bootstrap
      # FIXME
      left_player_position = Position.new(
        x: ,
        y:
      )

      # FIXME
      right_player_position = Position.new(
        x: ,
        y:
      )

      @player_left = Player.new(type: :human, position: left_player_position)
      @player_right = Player.new(type: :ai, position: right_player_position)
    end
  end
end
