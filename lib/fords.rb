class Ford
  @@filepath = nil

  def self.filepath=(path=nil)
  	@@filepath = File.join(APP_ROOT, path)
  end
  attr_accessor :model, :price, :dealer

  def self.file_exists?
  	# Class should know if a ford info file_exists
  	if @@filepath && File.exists?(@@filepath)
  	  return true
  	else
  	  return false
  	end
  end