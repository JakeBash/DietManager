# Ruby Diet Manager Project
# This file contains the food database
# Author: Jake Bashaw

require './BasicFood.rb'
require './Recipe.rb'

class FoodDB
  attr_accessor :db, :saved

  # Creates a fooddb object.
  # Parameters: A file to be read
  def initialize(file)
    @filePath = file.path
    @db = Hash.new
    @saved = true
    file.each do |line|
      line.chomp!
      food = line.split(',')
      if food[1] == 'b'
        @db[food[0]] = BasicFood.new(food[0], food[2])
        @saved = false
      elsif food[1] == 'r'
        ingredients = []
        food[2..-1].each {|bf| ingredients.push(@db[bf])}
        @db[food[0]] = Recipe.new(food[0], ingredients)
        @saved = false
      end
    end
  end

  # Gets a desired food/recipe from the database
  # Paramters: The name of the desired food/recipe
  def get(desiredFood)
    food = @db[desiredFood]
    food
  end

  # Checks whether or not the desired food/recipe is in the database
  # Parameters: The name of the desired food/recipe
  def contains(desiredFood)
    if @db.key?(desiredFood) == true
      return true
    else
      return false
    end
  end

  # Saves the food database
  # Parameters: None
  def save
    f = File.open(@filePath, 'w')
    dbString = ""
    @db.each_value do |food|
      dbString += "#{food.dbLine}\n"
    end
    f.write(dbString)
    f.close
    @saved = true
  end

end
