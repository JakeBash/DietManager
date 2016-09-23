# Ruby Diet Manager Project
# Unit tests for the diet manager project
# Author: Jake Bashaw

require 'test/unit'
require 'stringio'
require './FoodDB.rb'
require './ICL.rb'
require './Recipe.rb'
require './BasicFood.rb'
require './Log.rb'
require './LogItem.rb'
require 'date'

class TestGitMetrics < Test::Unit::TestCase
  def test_new_BasicFood
    bf = BasicFood.new("Pepper", 60)
    assert_equal("Pepper", bf.name)
    assert_equal(60, bf.cal)
  end

  def test_new_Recipe
    bf1 = BasicFood.new("Pepper", 60)
    bf2 = BasicFood.new("Carrot", 60)
    bf3 = BasicFood.new("Ranch Dressing", 60)
    ingredients = [bf1, bf2, bf3]
    recipe = Recipe.new("Veggie Dip", ingredients)
    assert_equal("Veggie Dip", recipe.name)
    assert_equal(ingredients, recipe.basicFoods)
  end

  def test_find
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    db = FoodDB.new(file)
    log = Log.new(logFile)
    icl = ICL.new(db, log)
    out = StringIO.new
    old_stdout = $stdout
    $stdout = out
    icl.commandPicker("find Or")
    $stdout = old_stdout
    actual = out.string
    assert_equal("\nOrange 67\n\n", actual)
  end

  def test_print
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    db = FoodDB.new(file)
    log = Log.new(logFile)
    icl = ICL.new(db, log)
    out = StringIO.new
    old_stdout = $stdout
    $stdout = out
    icl.commandPicker("print Orange")
    $stdout = old_stdout
    actual = out.string
    assert_equal("\nOrange 67\n\n", actual)
  end

  def test_add_food
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    db = FoodDB.new(file)
    log = Log.new(logFile)
    icl = ICL.new(db, log)
    icl.new("recipe Salsa,Orange,Orange")
    assert(db.contains("Salsa"), "Failure adding basic food")
  end

  def test_add_recipe
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    log = Log.new(logFile)
    db = FoodDB.new(file)
    icl = ICL.new(db, log)
    icl.new("food Chip,20")
    assert(db.contains("Chip"), "Failure adding recipe")
  end
 
  def test_show_all
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    db = FoodDB.new(file)
    log = Log.new(logFile)
    icl = ICL.new(db, log)
    icl.commandPicker("log Orange")
    icl.commandPicker("log Jelly")
    out = StringIO.new
    old_stdout = $stdout
    $stdout = out
    icl.commandPicker("show all")
    $stdout = old_stdout
    actual = out.string
    out = "\n"
    out += "#{Date.today.strftime("%D")}\n"
    out += "  Orange\n"
    out += "  Jelly\n"
    out += "\n"
    assert_equal(out, actual)
  end

  def test_log_name
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    db = FoodDB.new(file)
    log = Log.new(logFile)
    icl = ICL.new(db, log)
    icl.log("Orange")
    out = StringIO.new
    old_stdout = $stdout
    $stdout = out
    icl.commandPicker("show all")
    $stdout = old_stdout
    actual = out.string
    out = "\n"
    out += "#{Date.today.strftime("%D")}\n"
    out += "  Orange\n"
    out += "\n"
    assert_equal(out, actual)

  end

  def test_log_name_date
    file = File.open("FoodDB.txt")
    logFile = File.open("DietLog.txt")
    db = FoodDB.new(file)
    log = Log.new(logFile)
    icl = ICL.new(db, log)
    icl.log("Orange,4/24/16")
    out = StringIO.new
    old_stdout = $stdout
    $stdout = out
    icl.commandPicker("show all")
    $stdout = old_stdout
    actual = out.string
    out = "\n"
    out += "4/24/16\n"
    out += "  Orange\n"
    out += "\n"
    assert_equal(out, actual)
  end

end
