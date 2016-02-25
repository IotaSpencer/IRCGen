require "generator"
class Link < Builder
  # <link >
  attr :name, :ipaddr, :port, :allowmask, :autoconnect, :failover, :timeout, :ssl, :bind, :statshidden, :hidden, :sendpass, :recvpass


  def initialize
    super
    a = HighLine.new($stdin, $stderr,80)
    @name = ask("What's the irc.server.name you're going to be connecting to?") do |q|
      q.default = %q!irc.misconfigured.net!
    end
    @ipaddr = ask("What IP address is this server at?") do |q|
      q.validate = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
    end

    @port = ask("What port is this server connecting to on the remote server?") do |q|
      q.validate = /\d{4,5}/
    end

    @allowmask = ask("What mask should we allow? If 'ipaddr' isn't set we use this.") do |q|
      q.default = "0.0.0.0/0"
    end

    @autoconnect = ask("How often do we want to try to connect to this server if we're split from it? Default is to disable it.") do |q|
      q.default = nil
    end
    say "FailOver: If we can't connect to this block where else should we try?"
    say "You're mostly only going to use this block if you have multiple 'hub'y type servers."
    say "So by default we're going to disable it. Just enter nothing."
    @failover = ask("What link should we try if this one fails?") do |q|
      q.default = nil
    end

    say "Timeout: How long till our server should figure that it can't connect to this one. <%= color(\"in seconds\", :red, :bold) %>"
    @timeout = ask "How long?" do |q|
      q.validate = /\d+/
    end

    @ssl = ask "What SSL are you using? If none, just leave it blank." do |q|
      q.default = nil
    end
    @bind = ask "What IP are we binding to?" do |q|
      q.default = "127.0.0.1"
    end
    @statshidden = agree("Should we show opers the IP of this server when they do /stats c?", true)
    if @statshidden == true
      @statshidden = "yes"
    elsif @statshidden == false
      @statshidden = "no"
    end
    @hidden = agree(" do we want to hide this server from /map and /links? (Usually yes for services)", true)
    if @hidden == true
      @hidden = "yes"
    elsif @hidden == false
      @hidden = "no"
    end
    @sendpass = ask "What password should we send the other server?" do |q|
      q.default = "misconfigured!password"
    end
    @recvpass = ask "What password should we recieve from the other server?" do |q|
      q.default = "password!misconfigured"
    end
    say "<%= color(\"The other server will have these passwords reversed\", :red, :bold) %>"
    print
  end

  def print
    puts "<link name=\"#{@name}\"",
    "  ipaddr=\"#{@ipaddr}\"",
    "  port=\"#{@port}\"",
    "  allowmask=\"#{@allowmask}\""
    if !@autoconnect == ""
      puts "  autoconnect=\"#{@autoconnect}\""
    end
    if !@autoconnect == ""
      puts "  failover=\"#{@failover}\""
    end
    puts "  timeout=\"#{@timeout}\""
    if !@ssl == ""
      puts "  ssl=\"#{@ssl}\""
    end
    puts "  bind=\"#{@bind}\"",
    "  statshidden=\"#{@statshidden}\"",
    "  hidden=\"#{@hidden}\"",
    "  sendpass=\"#{@sendpass}\"",
    "  recvpass=\"#{@recvpass}\">"
  end
end
