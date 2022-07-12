class Bottles
  def song
    verses(99, 0)
  end

  def verses(start, finish)
    (finish..start).to_a.reverse.map(&method(:verse)).join("\n")
  end

  def verse(number)
    BottleFactory.build(number).verse
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

  def verse
    "#{index} bottles of beer on the wall, " +
      "#{index} bottles of beer.\n" +
      "Take one down and pass it around, " +
      "#{index - 1} bottles of beer on the wall.\n"
  end
end

class SecondLastBottle
  def verse
    "2 bottles of beer on the wall, " +
      "2 bottles of beer.\n" +
      "Take one down and pass it around, " +
      "1 bottle of beer on the wall.\n"
  end
end

class LastBottle
  def verse
    "1 bottle of beer on the wall, " +
      "1 bottle of beer.\n" +
      "Take it down and pass it around, " +
      "no more bottles of beer on the wall.\n"
  end
end

class NullBottle
  def verse
    "No more bottles of beer on the wall, " +
      "no more bottles of beer.\n" +
      "Go to the store and buy some more, " +
      "99 bottles of beer on the wall.\n"
  end
end