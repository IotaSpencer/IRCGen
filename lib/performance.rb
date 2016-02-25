require "generator"
class Performance < Builder
  attr :netbuffersize, :maxwho, :somaxconn, :softlimit, :quietbursts, :nouserdns

  def initialize
    super

    say "These options' help is grabbed right from the wiki."
    say ""
    say "NetBufferSize: Size of the buffer used to recieve data from clients. The ircd may only read this amount of text in 1 go at any time. |10240|"
    @netbuffersize = ask "? " do |q|
      q.default = "10240"
    end
    say ""
    say "MaxWho: Maximum number of results to show in a /who query. It is not recommended to set this above 1024. |128|"
    @maxwho = ask "" do |q|
      q.default = "128"
    end
    if @maxwho > 1024 or @maxwho < 1
      at_exit { puts "Invalid MaxWho Value" }
      exit 1
    end
    say ""
    say "SoMaxConn: The maximum number of connections that may be waiting in the accept queue.\n This is *NOT* the total maximum number of connections per server. Some systems may only allow this to be up to 5, while others (such as linux and *BSD) default to 128."
    @somaxconn = ask "? " do |q|
      q.default = "128"
    end
    if @somaxconn.to_i > 128 or @somaxconn.to_i < 1
      at_exit { puts "Invalid SoMaxConn Value" }
      exit 1
    end
    say ""
    say "SoftLimit: This optional feature allows a defined softlimit for connections. If defined, it sets a soft max connections value."
    @softlimit = ask "? " do |q|
      q.default = "12800"
    end
    if @softlimit.to_i > 5000 or @softlimit.to_i < 1
      at_exit { puts "Invalid SoftLimit Value" }
      exit 1
    end
    say ""
    say "QuietBursts: When syncing or splitting from a network, a server can generate a lot of connect and quit messages to opers with +C and +Q snomasks. Setting this to yes squelches those messages, which makes it easier for opers, but degrades the functionality of bots like BOPM/HOPM during netsplits."
    @quietbursts = agree("Do you want to enable quietbursts?", true)
    if @quietbursts == true
      @quietbursts = "yes"
    elsif @quietbursts == false
      @quietbursts = "no"
    end
    say ""
    say "NoUserDNS: If enabled, no DNS lookups will be performed on connecting users. This can save a lot of resources on very busy servers."
    @nouserdns = agree("Do you want to enable nouserdns?", true)
    if @nouserdns == true
      @nouserdns = "yes"
    elsif @nouserdns == false
      @nouserdns = "no"
    end
    print
  end


  def print
    puts \
      "<performance",
      "  netbuffersize=\"#{@netbuffersize}\"",
      "  maxwho=\"#{@maxwho}\"",
      "  somaxconn=\"#{@somaxconn}\"",
      "  softlimit=\"#{@softlimit}\"",
      "  quietbursts=\"#{@quietbursts}\"",
      "  nouserdns=\"#{@nouserdns}\">"
  end
end
