class Prompt
  # Loads the questions for the main configuration file.
  def self.conf
    load("conf.rb")
  end
  def self.connect
    load("connect.rb")
  end
  def self.limits
    load("limits.rb")
  end

end

