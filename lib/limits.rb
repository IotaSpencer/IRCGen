require "generator"
class Limits < Builder
  attr :maxnick, :maxchan, :maxmodes, :maxident, :maxquit, :maxtopic, :maxkick, :maxgecos, :maxaway

  def initialize
    super

    say "MaxNick: The maximum length a nickname can be. (RFC says 9, but due to ISUPPORT it is IRCd settable.)"
    @maxnick = ask "? " do |q|
      q.default = "31"
    end
    if @maxnick.to_i > 31 or @maxnick.to_i < 9
      at_exit { puts "Invalid MaxNick Value" }
      exit 1
    end
    say ""
    say "MaxChan: Maximum length of a channel name. You will most likely want to lower this from the default" do |q|
      q.default = "64"
    end
    if @maxchan.to_i > 64 or @maxchan.to_i < 9
      at_exit { puts "Invalid MaxChan Value" }
      exit 1
    end
    say ""
    say "MaxModes: Maximum modes per line."
    @maxmodes = ask "? " do |q|
      q.default = "20"
    end
    if @maxmodes.to_i > 20 or @maxmodes.to_i < 3
      at_exit { puts "Invalid MaxModes Value" }
      exit 1
    end
    say ""
    say "MaxIdent: Maximum length of an ident/username."
    @maxident = ask "? " do |q|
      q.default = "11"
    end
    if @maxident.to_i > 11 or @maxident.to_i < 1
      at_exit { puts "Invalid MaxIdent Value" }
      exit 1
    end
    say ""
    say "MaxQuit: Maximum length of a quit message."
    @maxquit = ask "? " do |q|
      q.default = "255"
    end
    if @maxquit.to_i > 500 or @maxquit.to_i < 20
      at_exit { puts "Invalid MaxQuit Value" }
      exit 1
    end
    say ""
    say "MaxTopic: Maximum length of a topic."
    @maxtopic = ask "? " do |q|
      q.default = "307"
    end
    if @maxtopic.to_i > 500 or @maxtopic.to_i < 50
      at_exit { puts "Invalid MaxTopic Value" }
      exit 1
    end
    say ""
    say "MaxKick: Maximum length of a kick message."
    @maxkick = ask "? " do |q|
      q.default = "255"
    end
    if @maxkick.to_i > 500 or @maxkick < 20
      at_exit { puts "Invalid MaxKick Value" }
      exit 1
    end
    say ""
    say "MaxGecos: Maximum length of a GECOS/realname"
    @maxgecos = ask "? " do |q|
      q.default = "128"
    end
    if @maxgecos.to_i > 500 or @maxgecos < 20
      at_exit { puts "Invalid MaxGecos Value" }
      exit 1
    end
    say ""
    say "MaxAway: Maximum length of an /away message."
    @maxaway = ask "? " do |q|
      q.default = "200"
    end
    if @maxaway.to_i > 500 or @maxaway < 20
      at_exit { puts "Invalid MaxAway Value" }
      exit 1
    end
    print
  end
  def print
    puts "<limits",
      "  maxnick=\"#{@maxnick}\"",
      "  maxchan=\"#{@maxchan}\"",
      "  maxmodes=\"#{@maxmodes}\"",
      "  maxident=\"#{@maxident}\"",
      "  maxquit=\"#{@maxquit}\"",
      "  maxtopic=\"#{@maxtopic}\"",
      "  maxkick=\"#{@maxkick}\"",
      "  maxgecos=\"#{@maxgecos}\"",
      "  maxaway=\"#{@maxaway}\">"
  end
end
