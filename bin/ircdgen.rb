#! /usr/bin/ruby

#--
# Gem Requires
require "slop"

#--
# Local Requires
#
require "builder"
require "version"
require "questions"

opts = Slop.parse do |o|
  o.banner = "Usage: #{$0} [options] ....."
  o.separator ""
  o.separator "Description:"
  o.separator <<-LINE
  This script can make your 'job' as server owner,
  routing team member, or just starting your own
  server up a whole lot easier

LINE
  o.separator ""
  o.separator "Main Options:"
  o.array "-t", "--type", "Type(s) of configuration files to generate.
    Types: conf, oper, link, connect, bind" do |a|
    case a
    when "conf"
      Gen.conf
    when "oper"
      Gen.opers
    when "link"
      Gen.link
    when "connect"
      Gen.connect
    when "bind"
      Gen.bind
    when "options"
      Gen.options
    else
      STDERR.puts "Invalid Selection."
      exit 1
    end
  end
  o.separator ""
  o.separator "Other Options"
  o.on '-v', '--version' do
    puts @Version.join(".")
    exit
  end
  o.on "-h", "--help", "Prints out help." do
    puts o
    exit
  end
end
puts opts if ARGV.length == 0
