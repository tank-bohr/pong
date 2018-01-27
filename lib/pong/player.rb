module Pong
  class Player

    attr_reader :type, :position

    def initialize(type:, position:)
      @type = type
      @position = position
      @score = 0
    end
  end
end
