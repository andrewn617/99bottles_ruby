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
    bottle = BottleRepository.find_or_create(number)

    "#{bottle} of beer on the wall, ".capitalize +
      "#{bottle} of beer.\n" +
      "#{bottle.action}, " +
      "#{bottle.next_bottle} of beer on the wall.\n"
  end
end

class BottleFactory
  def self.build(index)
    return SixPack.new if index == 6
    return SecondLastBottle.new if index == 2
    return LastBottle.new if index == 1
    return NullBottle.new if index == 0

    Bottle.new(index)
  end
end

class BottleRepository
  include Singleton

  def self.find_or_create(index)
    instance.find_or_create(index)
  end

  def initialize
    @repository = {}
  end

  def find_or_create(index)
    @repository[index] || create(index)
  end

  def create(index)
    @repository[index] = BottleFactory.build(index)
  end
end

class Bottle
  attr_reader :index

  def initialize(index)
    @index = index
  end

  def to_s
    "#{index} #{container}"
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

  def to_s
    "1 six-pack"
  end

  def pronoun
    "it"
  end
end

class SecondLastBottle < Bottle
  def initialize
    super(2)
  end

  def pronoun
    "one"
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
    BottleRepository.find_or_create(0)
  end
end

class NullBottle < Bottle
  def initialize
    super(0)
  end

  def to_s
    "no more #{container}"
  end

  def container
    "bottles"
  end

  def action
    "Go to the store and buy some more"
  end

  def next_bottle
    BottleRepository.find_or_create(99)
  end
end
