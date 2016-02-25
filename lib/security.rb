require "generator"
class Security < Builder
  attr :announceinvites, :hidemodes, :hideulines, :flatlinks, :hidewhois, :hidebans, :hidekills, :hidesplits, :maxtargets, :customversion, :operspywhois, :restrictbannedusers, :genericoper, :userstats

  def initialize
    super

    choose do |menu|
      menu.prompt = "In which way do we want to announce invites."
      menu.init_help
      menu.choice(:none, " don't announce invites at all.") do |m|
        @announceinvites = "none"
      end
      menu.choice(:ops, "Only show to ops in the channel.") do |m|
        @announceinvites = "ops"
      end
      menu.choice(:dynamic, "Show invites to those with access to /invite in the channel.") do |m|
        @announceinvites = "dynamic"
      end
      menu.choice(:all, "Announce all invites to all users of each channel.") do |m|
        @announceinvites = "all"
      end
    end
    say "HideModes: Defines what modes to hide from users that are not halfop or higher."
    @hidemodes = ask "? " do |q|
      q.validate = /(?:([beI])(?!.*\1))/
    end
    if @hidemodes.split(",").include? "b"
      say "<%= color(\"Note\":red) %> Including b will break some clients, mIRC etc."
      agree("Are you sure you want to hide the banlist?", true) do |m|
        m.confirm = "Are you really sure?"
      end
    end
    say "HideUlines: Want to hide U-Lines from non-opers in /map and /links"
    if agree("? ", true)
      @hideulines = "yes"
    else
      @hideulines = "no"
    end
    say "FlatLinks: Flattens /map and /links and makes it seem like all servers are linked to each other."
    if agree("? ", true)
      @flatlinks = "yes"
    else
      @flatlinks = "no"
    end
    say "HideWhois: 'When defined, the given text will be used in place of the server a user is on when whoised by a non-oper. Most networks will want to set this to something like \"*.netname.net\" to conceal the actual server a user is on.'"
    @hidewhois = ask "? " do |q|
      q.confirm = "Are you sure?"
    end
    say "HideBans: 'If this value is set to yes, when a user is banned ([gkz]lined) only opers will see the ban message when the user is removed from the server.'"
    if agree("? ", true)
      @hidebans = "yes"
    else
      @hidebans = "no"
    end
    say "HideKills: If defined, replaces who set a /kill with a custom string."
    @hidekills = ask "? "
    say "HideSplits: If enabled, non-opers will not be able to see which servers split in a netsplit, they will only be able to see that one occurred (If their client has netsplit detection)."
    if agree("? ", true)
      @hidesplits = "yes"
    else
      @hidesplits = "no"
    end
    say "MaxTargets: Maximum number of targets per command. (Commands like /notice, /privmsg, /kick, etc)"
    @maxtargets = ask "? " do |q|
      q.default = "1"
    end
    if @maxtargets.to_i > 20 or @maxtargets.to_i < 1
      puts "Invalid MaxTargets Value"
      exit 1
    end
    say "CustomVersion: Displays a custom string when a user /version's the ircd. This may be set for security reasons or vanity reasons."
    @customversion = ask "? " do |q|
      q.default = "MyIRCd v2.0"
    end
    say "OperSpyWhois: If this is set to yes, when a oper /whois 's a user, it will show all channels the user is in including +s and +p channels."
    if agree("? ", true)
      @operspywhois = "yes"
    else
      @operspywhois = "no"
    end
    say "RestrictBannedUsers: If this is set to yes, InspIRCd will not allow users banned on a channel to change nickname or message channels they are banned on."
    if agree("? ", true)
      @restrictbannedusers = "yes"
    else
      @restrictbannedusers = "no"
    end
    say "GenericOper: Setting this value to yes makes all opers on this server appear as 'is an IRC operator' in their WHOIS, regardless of their oper type, however oper types are still used internally. This only affects the display in WHOIS."
    if agree("? ", true)
      @genericoper = "yes"
    else
      @genericoper = "no"
    end
    say "UserStats: /stats commands that users can run (opers can run all)."
    @userstats = ask "? " do |q|
      q.default = "Pu" # Let users see online opers and uptime of the server.
      #q.validate = /(?:([beI])(?!.*\1))/
    end
    print

  end

  def print
    puts \
      "<security",
      "  announceinvites=\"#{@announceinvites}\"",
      "  hidemodes=\"#{@hidemodes}\"",
      "  hideulines=\"#{@hideulines}\"",
      "  flatlinks=\"#{@flatlinks}\"",
      "  hidewhois=\"#{@hidewhois}\"",
      "  hidebans=\"#{@hidebans}\"",
      "  hidekills=\"#{@hidekills}\"",
      "  hidesplits=\"#{@hidesplits}\"",
      "  maxtargets=\"#{@maxtargets}\"",
      "  customversion=\"#{@customversion}\"",
      "  operspywhois=\"#{@operspywhois}\"",
      "  restrictbannedusers=\"#{@restrictbannedusers}\"",
      "  genericoper=\"#{@genericoper}\"",
      "  userstats=\"#{@userstats}\">"
  end
end
