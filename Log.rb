# Ruby DietManager Project
# This file handles the logging of foods into the log file.
# Author: Jake Bashaw

require 'date'

class Log
  attr_accessor :path, :saved, :logHash

  # Creates a new log object
  # Parameters: The diet log file to be written to
  def initialize(file)
    @filePath = file.path
    @saved = true
    @logHash = Hash.new([])
  end

  # Saves the log to a file
  # Parameters: None
  def save
    f = File.open(@filePath, 'w')
    logString = ""
    dates = @logHash.keys
    printList = []
    dates.each do |date|
      @logHash[date].each{|logItem| printList.push(logItem)}
    end
    printList.each{|logItem| logString += "#{logItem.logLine}\n"}
    f.write(logString)
    f.close
    @saved = true
  end

  # Returns a printable string for the given date in the log
  # Parameters: The desired date
  def logString(date)
    string = "#{date}\n"
    foodList = []
    @logHash[date].each{|logItem| foodList.push(logItem)}
    foodList.each{|logItem| string += "  #{logItem.name}\n"}
    string
  end

end
