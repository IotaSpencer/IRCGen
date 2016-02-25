require "generator"
require "pconf"
class Conf < Builder
  # <server>
  attr_accessor :name, :info, :id, :net
  # <admin>
  attr_accessor :name, :nick, :e_mail
  # <connect>
  attr_accessor :maxchans, :timeout, :pingfreq, :sendq, :recvq, :localmax, :globalmax, :umodes

  def initialize
    super

    # Conf generation
    # <server>
    say "Alright, first off"
    say "1. Lets get the irc.server.name"
    say "2. Your server info/server description/sdesc"
    say "3. Your numeric. (Talk to your network's routing team or whoever manages linking)"
    say "This will be your <server> block"
    @sname = ask "Server Name? "
    @info = ask "Server Description? "
    @id = ask("SID? ") do |q|
      q.validate = /\d[0-9A-Z][0-9A-Z]/
    end
    @net = ask "What Network Name? "

    # <admin>
    say "Here we get our <admin> lines."
    @name = ask("What is your Name: ") do |q|
      q.validate = /([A-Za-z\s\S]+)/
    end
    @nick = ask("What is your Nick: ") do |q|
      q.validate = /[A-Za-z0-9\-\[\]\{\}\^`\\]+/
    end
    @e_mail = ask("What is your E-Mail: ") do |q|
      q.validate = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/
    end
    say ""
    say "Alright, the next bit will get your settings for your <connect> block. First thing, since conf generation usually means you're starting out, we're going to default to allow. You can generate more <connect> blocks using the the '-t connect' options when starting the script."
    say "We also default to allow=\"*\""
    say "Ping Frequency: The number of seconds between pings from the server (90-240 recommended)"
    say "This is the frequency at which the server pings you."
    say "You want to set this low enough that you have accurate/real connections, but also high enough for some laggy or 'stupid' clients."
    @pingfreq = ask "?" do |q|
      q.default = "240"
    end
    if @pingfreq.to_i > 600 || @pingfreq.to_i < 60
      at_exit { puts "Invalid PingFreq Value" }
      exit 1
    end
    say ""
    say "TimeOut: This is the amount of seconds the server will wait before disconnecting a user when doing registration (the auth ak /nick /user, /pass)"
    @timeout = ask "?" do |q|
      q.default = "60"
    end
    if @timeout.to_i > 120 || @timeout.to_i < 20
      at_exit { puts "Invalid Timeout Value" }
      exit 1
    end
    say ""
    say "Max Local Clients: Specifies the maximum amount of clients <%= color(\"per IP\", :red, :bold) %> on this server."
    say ""
    say "Note: 3-5 recommended"
    @localmax = ask "?" do |q|
      q.default = "5"
    end
    if @localmax.to_i > 1000 || @localmax.to_i < 1
      at_exit { puts "Invalid LocalMax Value" }
      exit 1
    end
    say ""
    say "Max Global Clients: Specifies the maximum amount of clients <%= color(\"per IP\", :red, :bold) %> network-wide."
    say ""
    say "Note: 3-5 recommended"
    @globalmax = ask "?" do |q|
      q.default = "5"
    end
    if @globalmax.to_i > 1000 || @globalmax.to_i < 1
      at_exit { puts "Invalid GlobalMax Value" }
      exit 1
    end
    say ""
    say "Max Channels: Specifies the maximum number of channels users in this block can join. The validation range goes to 1000, if you want to increase it, enter a random number or accept the default.  This overrides every other maxchans setting."
    @maxchans = ask "?" do |q|
      q.default = "100"
    end
    if @maxchans.to_i > 1000 || @maxchans.to_i < 20
      at_exit { puts "Invalid MaxChans Value" }
      exit 1
    end
    say ""
    say "Send Quota(SendQ): Amount of data that can be in the send queue"
    say ""
    say "Note: ~100000+ recommended"
    @sendq = ask "?" do |q|
      q.default = "131074"
    end
    if @sendq.to_i > 1000000 || @sendq.to_i < 5000
      at_exit { puts "Invalid SendQ Value" }
      exit 1
    end
    say ""
    say "Receive Quota(RecvQ): Amount of data that can be in the receive queue
    Note: 3000-8000 recommended."
    @recvq = ask("?") do |q|
      q.default = "4096"
    end
    if @recvq.to_i > 10000 || @recvq.to_i < 3000
      at_exit { puts "Invalid RecvQ Value" }
      exit 1
    end
    say ""
    say "Modes on Connect: If you want to have certain user modes added to clients on connect, put them here."
    @umodes = ask("?") do |q|
      q.default = "+ix"
    end
    print
  end
  def print
    puts \
      "/*",
      "# - Regular comment",
      "/* text */",
      "# and /* */ can be inline comments",
      "and as you can see /**/ can also be multiline comments",
      "*/"
    # <server>
    puts \
      "<server",
      "  name=\"#{@sname}\"",
      "  description=\"#{@info}\"",
      "  id=\"#{@id}\"",
      "  network=\"#{@net}\">"
    # <admin>
    puts \
      "<admin",
      "  name=\"#{@name}\"",
      "  nick=\"#{@nick}\"",
      "  email=\"#{@e_mail}\">"
    # <connect>
    puts \
      "<connect",
      "  allow=\"*\"",
      "  maxchans=\"#{@maxchans}\"",
      "  timeout=\"#{@timeout}\"",
      "  pingfreq=\"#{@pingfreq}\"",
      "  sendq=\"#{@sendq}\"",
      "  recvq=\"#{@recvq}\"",
      "  localmax=\"#{@localmax}\"",
      "  globalmax=\"#{@globalmax}\"",
      "  useident=\"no\"",
      "  limit=\"5000\"",
      "  modes=\"#{@umodes}\">"
  end
end