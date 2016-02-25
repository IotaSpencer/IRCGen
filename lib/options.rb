require "generator"
class Options < Builder
  # <options>
  attr :fixedquit, :fixedpart
  attr_accessor :prefixquit, :suffixquit, :prefixpart, :suffixpart, :syntaxhints, :cyclehosts, :ircumsgprefix, :announcets, :hostintopic, :pingwarning, :serverpingfreq, :defaultmodes, :moronbanner, :exemptchanops, :invitebypassmodes

  def initialize
    super

    if agree(" do you want to set a fixed quit message?(Users can't have a custom quit message,but it eliminates the /QUIT message spam that it allows.)", true)
      @fixedquit = ask "What should it be?" do |q|
        q.default = "[redacted]"
      end
    else
      @fixedquit = nil
      @prefixquit = ask "? " do |q|
        q.default = "Quit: "
      end
      @suffixquit = ask("What would you like to be the string that comes after a user's quit message?") do |q|
        q.default = "" # Top IRC Networks and IRCds do not use a suffix
      end
    end
    if agree(" do you want to set a fixed part message? (Users can't have a custom part message,\nbut it eliminates the /PART msg spam that it allows.)", true)
      @fixedpart = ask "What should it be?" do |q|
        q.default = "[redacted]"
      end
    else
      @fixedpart = nil # Set it to nothing
      @prefixpart = ask("What should come before a users /PART message, a string or character works.") do |q|
        q.default = "&quot;"
      end
      @suffixpart = ask("What should come after a users /PART message,  a string or character works.") do |q|
        q.default = "&quot;"
      end
      @syntaxhints = agree("When a user inputs a command and doesn't get the parameters right,\nshould we show them the syntax? [y/n]", true)
      if @syntaxhints == true
        @syntaxhints = "yes"
      elsif @syntaxhints == false
        @syntaxhints = "no"
      end
      @cyclehosts = agree("When a users host changes, should we make it look like they quit/parted and rejoined? [y/n]", true)
      if @cyclehosts == true
        @cyclehosts = "yes"
      elsif @cyclehosts == false
        @cyclehosts = "no"
      end
      @ircumsgprefix = agree(" do you want to use the Undernet/ircu style NOTICE/PRIVMSG message prefixing? [y/n]", true)
      if @ircumsgprefix == true
        @ircumsgprefix = "yes"
      elsif @ircumsgprefix == false
        @ircumsgprefix = "no"
      end
      say "Announce TS: If you set this to yes, all users will be shown a message if a channel they are in has a timestamp change."
      @announcets = agree("Do you want to enable 'announcets'? [y/n]", true)
      if @announcets == true
        @announcets = "yes"
      elsif @announcets == false
        @announcets = "no"
      end
      @hostintopic = agree("Do you want to enable 'hostintopic'? [y/n]", true)
      if @hostintopic == true
        @hostintopic = "yes"
      elsif @hostintopic == false
        @hostintopic = "no"
      end
      say "The rest of the <options> 'options' are string based, not yes/no"
      say "Ping Warning: If a server does not respond to a ping within x seconds, it will send a notice to opers with snomask +l informing them that the server is about to ping timeout. (pulled from InspIRCd Doc.)"
      @pingwarning = ask("After how many seconds should we send the message?") do |q|
        q.default = "15".to_i
      end
      say "Server Ping Frequency: Seconds between this server pinging other servers."
      @serverpingfreq = ask("How often should it ping?") do |q|
        q.default = "60".to_i
      end
      say "Default Modes: The modes that are set on a channel when it is first joined."
      @defaultmodes = ask "What modes?" do |q|
        q.default = "nt"
      end
      say "Moron Banner: Displayed to a user when they are banned generically."
      @moronbanner = ask("What should the server display?") do |q|
        q.default = "You're banned! Email haha-didnt-configure@abuse.com with the ERROR line below for help."
      end
      say "ExemptChanOps: List of channel modes to exempt ops from being affected by. Supported: [TCGfcSFBgN] / The default is to have them be immune to no modes."
      @exemptchanops = ask "What channel modes?" do |q|
        q.default = ""
      end
      say "Should /invite use allow someone to <%= color(\"override\", :red, :bold) %> +kjl?"
      if agree("? ", true)
        @invitebypassmodes = "yes"
      else
        @invitebypassmodes = "no"
      end
    end
    print
  end
  def print
    # <options> etc.
    puts \
      "<options"
    if @fixedquit
      "  fixedquit=\"#{@fixedquit}\""
    else
      puts "  prefixquit=\"#{@prefixquit}\"",
      "  suffixquit=\"#{@suffixquit}\""
    end
    if @fixedpart
      puts "  fixedpart=\"#{@fixedpart}\""
    else
      puts "  prefixpart=\"#{@prefixpart}\"",
      "  suffixpart=\"#{@suffixpart}\""
    end
      puts \
      "  syntaxhints=\"#{@syntaxhints}\"",
      "  cyclehosts=\"#{@cyclehosts}\"",
      "  ircumsgprefix=\"#{@ircumsgprefix}\"",
      "  announcets=\"#{@announcets}\"",
      "  hostintopic=\"#{@hostintopic}\"",
      "  pingwarning=\"#{@pingwarning}\"",
      "  serverpingfreq=\"#{@serverpingfreq}\"",
      "  defaultmodes=\"#{@defaultmodes}\"",
      "  moronbanner=\"#{@moronbanner}\"",
      "  exemptchanops=\"#{@exemptchanops}\"",
      "  invitebypassmodes=\"#{@invitebypassmodes}\">"
  end
end




