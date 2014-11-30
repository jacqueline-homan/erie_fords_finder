class Ford
  @@filepath = nil

  def self.filepath=(path=nil)
  	@@filepath = File.join(APP_ROOT, path)
  end
  attr_accessor :make, :model, :price, :year, :dealer

  def self.file_exists?
  	# Class should know if a ford info file_exists
  	if @@filepath && File.exists?(@@filepath)
  	  return true
  	else
  	  return false
  	end
  end

  def self.file_usable?
    return false unless @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)
    return true
  end

  def self.create_file
  	# create fords file
    File.open(@@filepath, 'w') unless file_exists?
    return file_usable?
  end       
  
  def self.saved_fords
  	# reads from the ford trucks file
    fords = []
  	# read from the file and return instances of a ford truck
    if file_usable?
      file = File.new(@@filepath, 'r')
      file.each_line do |line|
        fords << Ford.new.import_line(line.chomp)
      end
      file.close
    end
    return fords
  end

  def self.build_from_questions
    args = {}
     
    
    print "Model: "
    args[:model] = gets.chomp.strip
    
    print "Year: "
    args[:year] = gets.chomp.strip
    
    print "Price: "
    args[:price] = gets.chomp.strip
     
    print "Dealer: "
    args[:dealer] = gets.chomp.strip
    
    return self.new(args)
  end

  def initialize(args={})      
    @model   = args[:model]   || ""
    @year    = args[:year]    || ""
    @price   = args[:price]   || ""
    @dealer  = args[:dealer]  || ""
  end

  def import_line(line)
    line_array = line.split("\t")
     @model, @year, @price, @dealer = line_array
    return self
  end

  def save
    return false unless Ford.file_usable?
    File.open(@@filepath, 'a') do |file|
      file.puts "#{[@model, @year, @price, @dealer].join("\t")}\n"
    end
    return true
  end
end