# Ruby Diet Manager Project
# This file handles all of the keyboard commands.
# Author: Jake Bashaw

require './FoodDB.rb'
require './Log.rb'
require './LogItem.rb'
require 'date'

class ICL
  attr_accessor :foodDB, :log

  # Creates a new icl object
  # Parameters: a fooddb object, and a log object
  def initialize(db, log)
    @foodDB = db
    @log = log
    @running = true
  end

  # Starts requesting and processing user input.
  # Parameters: None
  def run
    while @running
      input = gets
      commandPicker(input)
    end
  end

  # Calls the desired command function based on user input
  # Paramters: a string of user input
  def commandPicker(input)
    input.chomp!
    inputa = input.split(' ')
    comm = inputa[0]
    if inputa.size > 1
      arg = input[input.index(' ')+1..-1]
    end

    case comm
    when "print"
      puts 
      print(arg)
      puts
    when "quit"
      quit
    when "find"
      puts
      find(arg)
      puts
    when "new"
      new(arg)
      puts
    when "save"
      save
      puts
    when "log"
      log(arg)
      puts
    when "show"
      puts
      show(arg)
      puts
    else
      puts
      puts "Command doesn't exist...."
      puts
    end
  end

  #COMMANDS

  # Prints the desired food or prints the entire database.
  # Parameters: The desired food/recipe to be printed or "all"
  def print(arg)
    if arg == "all"
      print_all
    elsif @foodDB.contains(arg)
      puts(@foodDB.get(arg).toString)
    end
  end

  # Prints all of the contents of the database
  # Parameters: None
  def print_all
    @foodDB.db.each_value do |food|
      puts food.toString
    end
  end

  # Prints information on all the foods in the database that begin with the given prefix
  # Parameters: The prefix being searched for
  def find(arg)
    arg.downcase!
    @foodDB.db.each_key do |foodName|
      if(foodName.downcase.include? arg)
        print(foodName)
      end
    end
  end

  # Saves a new basic food and its calories, or saves a new recipe and its foods.
  # Parameters: A basic food and its calorie count or a recipe and its basic foods.
  def new(arg)
    args = arg.split(' ')
    argc = arg.split(',')
    if args[0] == "food"
      foodInfo = args[1].split(',')
      name = foodInfo[0]
      cal = foodInfo[1]
      if @foodDB.contains(name)
        puts "Food already exists in the database."
        return
      else
        @foodDB.db[name] = BasicFood.new(name, cal)
      end
    elsif args[0] == "recipe"
      if args.size == 2
        # name with one word
        names = args[1].split(',')
        name = names[0]
        basicFoods = names[1..-1]
      else
        # name with multiple words
        typeName = argc[0].split(' ')
        nameArr = typeName[1..-1]
        name = nameArr.join(' ')
        basicFoods = argc[1..-1]
      end
      ingredients = []
      basicFoods.each do |bf|
        if @foodDB.contains(bf) == false
          puts "Food does not exist in the database."
          return
        else
          ingredients.push(@foodDB.get(bf))
        end
      end
      if @foodDB.contains(name)
        puts "Recipe already exists in the database."
        return
      else
        @foodDB.db[name] = Recipe.new(name, ingredients)
      end
    end
  end

  # Saves the food database
  # Parameters: None
  def save
    @foodDB.save
    @log.save
  end

  # Adds one unit of the named food to the log for the specified date, or the current day.
  # Parameters: Either the name or the name,date of the food item to be logged.
  def log(arg)
    info  = arg.split(",")
    food = info[0]
    if @foodDB.contains(food)
      if info.size > 1
        date = info[1]
      else
        date = Date.today.strftime("%D")
      end
    else
      puts "Food does not exist in the database"
    end
    @log.saved = false
    logItem = LogItem.new(food, date)
    @log.logHash[logItem.date] += [logItem]
  end

  # Shows the log of foods for all dates in the log, organized by ascending date.
  # Parameters: The string "all" to print all items in the log.
  def show(arg)
    if arg == "all"
      show_all
    else
      
    end
  end

  # Prints all of the foods currently in the log for all dates.
  # Parameters: None
  def show_all
    logString = ""
    @log.logHash.each_key {|date| logString += @log.logString(date)}
    puts logString
  end

  # Quits out of the diet manager
  # Parameters: None
  def quit
    if @foodDB.saved == false || @log.saved == false
      save
    end
    @running = false
  end

end
