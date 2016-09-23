# Ruby DietManager Project
# This class handles the log items that are placed into the log.
# Author: Jake Bashaw

require 'date'

class LogItem

  attr_accessor :name, :date

  # Creates a new LogItem object
  # Parameters: The name of the food being logged and the date.
  def initialize(name, date)
    @name = name
    @date = date
  end

  # Returns a string suitable for logging.
  # Parameters: 
  def logLine
    line = "#{date},#{name}"
    line
  end

end
