# Ruby Diet Manager Project
# This file handles basic foods.
# Author: Jake Bashaw

class BasicFood
  attr_accessor :name, :cal

  # Creates a basic food object
  # Parameters: The food's name, the food's calorie count
  def initialize(name, cal)
    @name = name
    @cal = cal.to_i
  end

  # Creates pritnable version of the basic food object
  # Parameters: None
  def toString
    str = "#{@name} #{@cal}"
    str
  end

  # Converts a basic food into a database style line
  # Paramters: None
  def dbLine
    line = "#{@name},b,#{@cal}"
    line
  end
end
