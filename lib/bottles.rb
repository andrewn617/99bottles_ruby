class Bottles
  def verses(*numbers)
    numbers.map(&method(:verse)).join("\n")
  end

  def verse(number)
    Bottle.new(number).verse
  end
end

class Bottle
  attr_reader :index

  def initialize(index)
    @index = index
  end

  def verse
    "#{remainder} #{bottle} of beer on the wall, " +
      "#{remainder.downcase} #{bottle} of beer.\n" +
      "#{take}" +
      "#{next_bottle} of beer on the wall.\n"
  end

  def bottle
    index == 1 ? "bottle" : "bottles"
  end

  def remainder
    index == 0 ? "No more" : index.to_s
  end

  def take
    return "Go to the store and buy some more, " if index == 0

    index == 1 ? "Take it down and pass it around, " : "Take one down and pass it around, "
  end

  def next_bottle
    return "99 bottles" if index == 0
    return "no more bottles" if index - 1 == 0

    index - 1 == 1 ? "1 bottle" : "#{index - 1} bottles"
  end
end