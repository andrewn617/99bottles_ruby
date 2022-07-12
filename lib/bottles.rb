class Bottles
  def verses(*numbers)
    numbers.map(&method(:verse)).join("\n")
  end

  def verse(number)
    "#{remainder(number)} #{bottle(number)} of beer on the wall, " +
      "#{remainder(number)} #{bottle(number)} of beer.\n" +
      "Take #{take(number)} down and pass it around, " +
      "#{remainder(number - 1)} #{bottle(number - 1)} of beer on the wall.\n"
  end

  def bottle(number)
    number == 1 ? "bottle" : "bottles"
  end

  def remainder(number)
    number == 0 ? "no more" : number
  end

  def take(number)
    number == 1 ? "it" : "one"
  end
end