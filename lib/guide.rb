require 'fords'

class Guide
  # You can have a class inside of a class
  class Config
    @@actions = ['list', 'find', 'add', 'quit']
    def self.actions; @@actions; end
  end

  def initialize(path=nil) 
  	# Locate the restaurant text file at that path
    Ford.filepath = path
  	  if Ford.file_usable?
  	    puts "Found Ford truck file" 
  	  # or create a new file
      elsif Ford.create_file
        puts "Created Ford truck file"
  	  # exit if file create fails
      else
        puts "Exiting. \n\n"
        exit!
    end
  end

  #def launch!
  	# intro #( welcome to the app, etc)
  	# action loop
    #loop do 
  	  # what do you want to do? (list, find, add, quit)
    #  print "(Enter response or type q to exit)> "
    #  user_response = gets.chomp
      
      # do that action
    #  result = do_action(user_response) 
  	  # repeat until user quits
      #break if user_response == "q"
    #  break if result == :quit
    #end
    #conclusion
  #end

  # Refactored the loop code block in def launch!
  def launch!
     intro #( welcome to the app, etc)
    # action loop
    result = nil
    until result == :quit 
      # what do you want to do? (list, find, add, quit)
      #print "(Enter response or type q to exit)> "
      #user_response = gets.chomp      
      # do that action
      action = get_action
      #result = do_action(user_response)
      result = do_action(action)      
    end
    conclusion
  end

  def get_action
    action = nil
    # Keep asking for user input until we get valid action
    until Guide::Config.actions.include?(action)
      puts "Actions: " + Guide::Config.actions.join(", ") if action
      print "(Enter response or type quit to exit)> "
      user_response = gets.chomp
      action = user_response.downcase.strip
    end
    return action   
  end


  def do_action(action)
    case action
    when 'list'
      list      
    when 'find'
      puts "Finding..."
    when 'add'
      add
    when 'quit'
      return :quit
    else
      puts "\nI don't understand that command.\n"
    end
  end

  def add
    puts "\nAdd a Ford truck\n\n".upcase
    
    ford = Ford.build_from_questions
    # An instance method on the Fords class that we'll save
    if ford.save
      puts "\nFord Truck Added\n\n"
    else
      puts "\nSave Error: Ford Truck Not Added\n\n"
    end 
  end

  def list
    puts "\nListing Ford Trucks\n\n".upcase
    fords = Ford.saved_fords    
    fords.each do |ford|
      puts ford.year + " | " + ford.model + " | " + ford.price + " | " + ford.dealer
    end
  end

  def intro
  	puts "\n\n<<<< Welcome to the Erie, PA Ford Trucks List >>>>\n\n"
  	puts "This is an interactive guide to help you track the Fords for sale you're interested in buying. \n\n"
  end

  def conclusion
  	puts "\n<<<< Goodbye (cue Ford commercial): Have you driven a Ford lately :) >>>>\n\n\n"
  end
end