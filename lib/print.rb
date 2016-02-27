require "highline/import"

class Print
  def initialize(file)
    @filename = file
    File.read("templates/" + file)
  end
  def conf

  end
end
