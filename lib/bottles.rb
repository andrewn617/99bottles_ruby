require "singleton"

class Bottles
  def song
    verses(99, 0)
  end

  def verses(start, finish)
    (finish..start)
      .to_a
      .reverse
      .map(&method(:verse))
      .join("\n")
  end

  def verse(number)
    bottle = BottleRepository.find_or_build(number)

    "#{bottle} of beer on the wall, ".capitalize +
      "#{bottle} of beer.\n" +
      "#{bottle.action}, " +
      "#{bottle.next_bottle} of beer on the wall.\n"
  end
end

class BottleFactory
  def self.build(index)
    case index
    when 6
      SixPack.new
    when 1
      LastBottle.new
    when 0
      NullBottle.new
    else
      Bottle.new(index)
    end
  end
end

class BottleRepository
  include Singleton

  def self.find_or_build(index)
    instance.find_or_build(index)
  end

  def initialize
    @repository = {}
  end

  def find_or_build(index)
    @repository[index] || build(index)
  end

  def build(index)
    @repository[index] = BottleFactory.build(index)
  end
end

class Bottle
  attr_reader :index

  def initialize(index)
    @index = index
  end

  def to_s
    "#{quantity} #{container}"
  end

  def quantity
    index.to_s
  end

  def container
    "bottles"
  end

  def action
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    "one"
  end

  def next_bottle
    BottleFactory.build(index - 1)
  end
end

class SixPack < Bottle
  def initialize
    super(6)
  end

  def quantity
    "1"
  end

  def container
    "six-pack"
  end

  def pronoun
    "it"
  end
end

class LastBottle < Bottle
  def initialize
    super(1)
  end

  def container
    "bottle"
  end

  def pronoun
    "it"
  end

  def next_bottle
    BottleRepository.find_or_build(0)
  end
end

class NullBottle < Bottle
  def initialize
    super(0)
  end

  def quantity
    "no more"
  end

  def container
    "bottles"
  end

  def action
    "Go to the store and buy some more"
  end

  def next_bottle
    BottleRepository.find_or_build(99)
  end
end
