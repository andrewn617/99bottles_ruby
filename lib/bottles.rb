class Bottles
  def song
    verses(99, 0)
  end

  def verses(start, finish)
    start.downto(finish)
      .map(&method(:verse))
      .join("\n")
  end

  def verse(number)
    bottle = BottleGroupRepository.find_or_build(number)

    "#{bottle} of beer on the wall, ".capitalize +
      "#{bottle} of beer.\n" +
      "#{bottle.action}, " +
      "#{bottle.next_bottle} of beer on the wall.\n"
  end
end

module BottleGroupFactory
  def self.build(index)
    registry[index].new(index)
  end

  def self.register(index, klass)
    registry[index] = klass
  end

  def self.registry
    @registry ||= Hash.new(BottleGroup)
  end
end

module BottleGroupRepository
  def self.find_or_build(index)
    repository[index] || build(index)
  end

  def self.repository
    @repository = {}
  end

  def self.build(index)
    repository[index] = BottleGroupFactory.build(index)
  end
end

class BottleGroup
  attr_reader :index

  def self.register_at(index)
    BottleGroupFactory.register(index, self)
  end

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
    BottleGroupRepository.find_or_build(index - 1)
  end
end

class SixPack < BottleGroup
  register_at 6

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

class SingleBottleGroup < BottleGroup
  register_at 1

  def container
    "bottle"
  end

  def pronoun
    "it"
  end

  def next_bottle
    BottleGroupRepository.find_or_build(0)
  end
end

class EmptyBottleGroup < BottleGroup
  register_at 0

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
    BottleGroupRepository.find_or_build(99)
  end
end
