class Bottles
  def song
    verses(99, 0)
  end

  def verses(start, finish)
    (finish..start).to_a.reverse.map(&method(:verse)).join("\n")
  end

  def verse(number)
    bottle = BottleFactory.build(number)

    "#{bottle} of beer on the wall, ".capitalize +
      "#{bottle} of beer.\n" +
      "#{bottle.action}, " +
      "#{bottle.next_bottle} of beer on the wall.\n"
  end
end

class BottleFactory
  def self.build(index)
    return SecondLastBottle.new if index == 2
    return LastBottle.new if index == 1
    return NullBottle.new if index == 0

    Bottle.new(index)
  end
end

class Bottle
  attr_reader :index

  def initialize(index)
    @index = index
  end

  def to_s
    "#{index} bottles"
  end

  def action
    "Take one down and pass it around"
  end

  def next_bottle
    BottleFactory.build(index - 1)
  end
end

class SecondLastBottle
  def to_s
    "2 bottles"
  end

  def action
    "Take one down and pass it around"
  end

  def next_bottle
    BottleFactory.build(1)
  end
end

class LastBottle
  def to_s
    "1 bottle"
  end

  def action
    "Take it down and pass it around"
  end

  def next_bottle
    BottleFactory.build(0)
  end
end

class NullBottle
  def to_s
    "no more bottles"
  end

  def action
    "Go to the store and buy some more"
  end

  def next_bottle
    BottleFactory.build(99)
  end
end
