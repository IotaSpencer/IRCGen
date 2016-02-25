require "generator"

class LinkX < Builder
  # <uline >
  attr :userver, :silent
  # <autoconnect >
  attr :period, :aserver, :aservercount

  def initialize
    super
    @userver = ask "What server are we uline'ing?" do |q|
      q.default = "hub.example.com"
    end
    @silent = agree("Should we not make connect notices when that server connects?", true)
    if @silent == true
      @silent = "yes"
    elsif @silent == false
      @silent = "no"
    end
    @period = ask "How often should this server try to connect to it's hub(s)" do |q|
      q.default = "60"
    end
    @aservercount = ask "How many servers are we connecting to? (names will be asked next)" do |q|
      q.default = "2"
    end
    @aserver = ask "What servers should we try to connect to?" do |q|
      q.gather = @aservercount.to_i
    end

    print
  end
  def print
    puts "<uline server=\"#{@userver}\" silent=\"#{@silent}\">"
    puts "<autoconnect period=\"#{@period}\" server=\"#{@aserver.join(" ")}\">"
  end
end

