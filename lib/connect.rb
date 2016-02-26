require "generator"
class Connect < Builder
  attr_accessor :type, :host, :maxchans, :timeout, :pingfreq, :sendq, :recvq, :localmax, :globalmax, :useident, :umodes, :wants_port, :port, :limit

  def initialize
    super
    choose do |menu|
      menu.prompt = "What kind of connect block do you want?"
      menu.choice(:allow, "Make a <connect> block that allows people on the network.") do |m|
        say("Ok")
        @type = "allow"
      end
      menu.choice(:deny, "Make a <connect> block that denies people from connecting.") do |m|
        say("Ok")
        @type = "deny"
      end
    end
    @host = ask("What IPv4/IPv6/hostname address is going to be affected by <connect #{@type}=\"...\"") do |q|
      q.default = "*"
    end

    say "Ping Frequency: The number of seconds between pings from the server (90-240 recommended)"
    say "This is the frequency at which the server pings you."
    say "You want to set this low enough that you have accurate/real connections, but also high enough for some laggy or 'stupid' clients."
    @pingfreq = ask("? ") do |q|
      q.default = "240"
    end
    if @pingfreq.to_i > 300 or @pingfreq.to_i < 0
      puts "Invalid PingFreq Value"
      exit 1
    end
    say "TimeOut: This is the amount of seconds the server will wait before disconnecting a user when doing registration (the auth ak /nick /user, /pass)"
    @timeout = ask("? ") do |q|
      q.default = "60"
    end
    if @timeout.to_i > 300 or @timeout.to_i < 0
      puts "Invalid TimeOut Value"
      exit 1
    end

    say "Max Local Clients: Specifies the maximum amount of clients <%= color(\"per IP\", :red, :bold) %> on this server.

    Note: 3-5 recommended"
    @localmax = ask("? ") do |q|
      q.default = "5"

    end
    if @localmax.to_i > 500 or @localmax.to_i < 0
      puts "Invalid LocalMax Value"
      exit 1
    end
    say "Max Global Clients: Specifies the maximum amount of clients <%= color(\"per IP\", :red, :bold) %> network-wide
    Note: 3-5 recommended"
    @globalmax = ask("? ") do |q|
      q.default = "5"
    end
    if @globalmax.to_i > 500 or @globalmax.to_i < 0
      puts "Invalid GlobalMax Value"
      exit 1
    end
    say ""
    say "Max Channels: Specifies the maximum number of channels users in this block can join. The validation range goes to 1000, if you want to increase it, enter a random number or accept the default.  This overrides every other maxchans setting."
    @maxchans = ask("? ") do |q|
      q.default = "100"
    end
    if @maxchans.to_i > 1000 or @maxchans.to_i < 20
      puts "Invalid MaxChans Value"
      exit 1
    end
    say ""
    say "Send Quota(SendQ): Amount of data that can be in the send queue
    Note: ~100000+ recommended"
    @sendq = ask("? ") do |q|
      q.default = "131074"
    end
    if @sendq.to_i > 1000000 or @sendq.to_i < 1
      puts "Invalid SendQ Value"
      exit 1
    end

    say ""
    say "Receive Quota(RecvQ): Amount of data that can be in the receive queue
    Note: 3000-8000 recommended."
    @recvq = ask("? ") do |q|
      q.default = "4096"
    end
    if @recvq.to_i > 10000 or @recvq.to_i < 3000
      puts "Invalid RecvQ Value"
      exit 1
    end
    say ""
    say "UseIdent: Determines whether you have to be using identd to be eligible for this connect block."
    if agree(" do you want users to have to use ident to connect via this block? ", true)
      @useident = "yes"
    else
      @useident = "no"
    end
    if agree(" do you want clients using this block to have to connect to a certain port.", true)
      say "Port: The port the client must connect to to be eligible for this connect block."
      say "What port do you want them to use."
      @port = ask("? ") do |q|
        q.default = "6667"
        @wants_port = true
      end
      if @port.to_i > 65536 or @port < 1024
        if @port.to_i < 1024
          puts " don't start IRC on privledged ports!"
        elsif @port.to_i > 65536
          puts "Ports above 65536 do not exist!"
        end
        exit 1
      end
    else
      @wants_port = false
      @port = ""
    end
    say "Limit: The number of clients total that this class can apply to."
    @limit = ask("? ") do |q|
      q.default = "5000"
    end
    if @limit.to_i > 30000 or @limit.to_i < 20
      puts "Invalid Limit Value"
      exit 1
    end
    say "Modes on Connect: If you want to have certain user modes added to clients on connect, put them here."
    @umodes = ask("? ") do |q|
      q.default = "+ix"
    end
    print
  end
end
