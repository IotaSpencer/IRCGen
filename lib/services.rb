require "generator"
class Services < Builder
  attr :name, :ipaddr, :port, :allowmask, :timeout, :ssl, :bind, :statshidden, :hidden, :sendpass, :recvpass

  def initialize
    super
    a = HighLine.new($stdin, $stderr,80)
    @name = ask("What's the server name you're going to be connecting to?") do |q|
      q.default = "services.example.com"
    end
    @ipaddr = ask("What IP address is this server at?") do |q|
      q.validate = /^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/
      q.default = "127.0.0.1"
    end

    @port = ask("What port is this server connecting to on the remote server?") do |q|
      q.validate = /\d{4,5}/
    end

    @allowmask = ask("What mask should we allow? If 'ipaddr' isn't set we use this.") do |q|
      q.default = "0.0.0.0/0"
    end
    say "-----------------"
    say "AutoConnect and Failover are disabled for services servers, 'In Services Packages, Server connect to you!'"
    say "-----------------"
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
    @hidden = agree("Do we want to hide this server from /map and /links? (Usually yes for services)", true)
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
    puts \
      "<link name=\"#{@name}\"",
      "  ipaddr=\"#{@ipaddr}\"",
      "  port=\"#{@port}\"",
      "  allowmask=\"#{@allowmask}\"",
      "  timeout=\"#{@timeout}\""
    if !@ssl.nil?
      puts "  ssl=\"#{@ssl}\""
    end
    puts \
      "  bind=\"#{@bind}\"",
      "  statshidden=\"#{@statshidden}\"",
      "  hidden=\"#{@hidden}\"",
      "  sendpass=\"#{@sendpass}\"",
      "  recvpass=\"#{@recvpass}\">"
  end
end
