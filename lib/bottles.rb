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
      "#{remainder} #{bottle} of beer.\n" +
      "Take #{take} down and pass it around, " +
      "#{next_bottle} of beer on the wall.\n"
  end

  def bottle
    index == 1 ? "bottle" : "bottles"
  end

  def remainder
    index == 0 ? "no more" : index
  end

  def take
    index == 1 ? "it" : "one"
  end

  def next_bottle
    return "no more bottles" if index - 1 == 0

    index - 1 == 1 ? "1 bottle" : "#{index - 1} bottles"
  end
end