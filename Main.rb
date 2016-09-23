# Ruby Diet Manager Project
# The main file for the Diet Manager
# Author: Jake Bashaw

require './ICL.rb'

dbFile = File.open("FoodDB.txt")
logFile = File.open("DietLog.txt")
db = FoodDB.new(dbFile)
log = Log.new(logFile)
icl = ICL.new(db, log)

icl.run
