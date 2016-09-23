# Ruby Diet Manager Project
# This file handles recipes.
# Author: Jake Bashaw

require './BasicFood.rb'

class Recipe
  attr_accessor :name, :cal, :basicFoods

  # Creates a new recipe object.
  # Parameters: Recipe name, list of basic food objects
  def initialize(name, ingredients)
    @name = name
    @cal = 0
    @basicFoodNames = []
    @basicFoods = ingredients
    ingredients.each do |bf|
      @cal += bf.cal
      @basicFoodNames.push(bf.name)
    end
  end

  # Creates a printable version of a recipe object
  # Parameters: None
  def toString
    str = "#{@name} #{@cal}\n"
    @basicFoods.each do |food|
      str += "  #{food.name} #{food.cal}\n"
    end
    str
  end

  # Converts a recipe into a database style line
  # Parameters: None
  def dbLine
    line = "#{@name},r,#{@basicFoodNames.join(',')}"
    line
  end

end
