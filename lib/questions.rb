$:.unshift File.dirname($0)
#Libraries
require "generator"

# Custom Code
require "conf"
require "oper"
require "connect"
require "bind"
require "link"
require "ospl"
require "link-extra"
require "services"

class Gen
  def conf
    STDERR.puts "You have selected the main inspircd.conf generator"
    Conf.new
  end
  def options
    STDERR.puts "You have selected the options  etc. portion of the inspircd.conf generator"
    Ospl.new
  end
  def opers
    STDERR.puts "You have selected the InspIRCd opers.conf/<oper> block generator"
    Oper.new
    while agree("Would you like to make another one?", true)
      Oper.new
    end
  end
  def connect
    STDERR.puts "You have selected the InspIRCd connect.conf/<connect> block generator"
    Connect.new
    while agree("Would you like to make another one?", true)
      Connect.new
    end
  end
  def link
    while agree("Want to make some link type blocks?", true)
      choose do |menu|
        menu.prompt = "Which type of block from links.conf would you like to make?"
        menu.choice(:link, "Regular <link > block") do |m|
          STDERR.puts "You have selected the InspIRCd links.conf/<link> block generator"
          Link.new
        end
        menu.choice(:extra, "The extra parts of links.conf (<autoconnect > <uline >)") do |m|
          STDERR.puts "Selected the generator for the extra parts of links.conf/<link>"
          LinkX.new
        end
        menu.choice(:services, "Make a link block for a services package") do |m|
          STDERR.puts "Selected the generator for a services link."
          Services.new
        end
        menu.choice(:exit, "Leave the program") do |m|
          puts "Exiting..."
          exit 0
        end
      end
    end
  end
  def bind
    STDERR.puts "You have selected the InspIRCd bind.conf/<bind> block generator"
    Bind.new
    while agree("Would you like to make another one?", true)
      Bind.new
    end
  end
end
