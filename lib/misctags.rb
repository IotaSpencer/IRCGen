require "generator"
require ""
class Misc
  # <files > or <execfiles >
  attr :motd, :rules, :exec
  # <pid >
  attr :pid
  # <log >
  attr :method, :type, :level, :target

  def initialize
    super

    say "The tag in which the /motd and /rules get defined can be either an exectuable files tag, or just 'included'"
    say "Including the files is done with <files>, while executing a program to make the files is done with <execfiles>"
    say "So..."
    if agree("Do you want to use a script to generate your /motd and /rules files?")
      @exec = true
      say "Ok you want to use a script to generate the /motd and /rules."
      say "There are a few ways to do this, you can reference a script on the same box/server,\n using /full/system/path/here -options"
      say ""
      say "Or you can reference a remote script like one used via http, like this:"
      say "/usr/bin/wget -q -O - http(s)://somesite.com/script/path/here"

      say "What's it going to be?"
      @motd = ask "? " do |q|
        q.default = "bin/motd"
      end
      say "Same stuff for the /rules script."
      @rules = ask "? " do |q|
        q.default = "bin/rules"
      end
      say "Next is the pid file, where the IRCd keeps its Process ID or 'PID' for short. This is relative to your ircd's 'run' directory."
      @pid = ask "? " do |q|
        q.default = "inspircd.pid"
      end
      say "Finally, the last thing would be your <log> tag, which allows you to log ircd errors and such if anything were to happen."
      say "<%= color(\"Note\", :red) %>: If you choose sql, you must have a SQL backend and m_sqllog loaded"
      choose do |menu|
        menu.prompt = "In which way do you want your events to be logged?"
        menu.init_help
        menu.choice(:file, "Use a regular file for logging.") do |m|
          @method = "file"
        end
        menu.choice(:sql, "Use a SQL provider for logging.") do |m|
          @method = "sql"
        end
      end
      if @method == "sql"
          say "<%= color(\"Note:\", :red) %> Make sure you load m_sqllog and use a sql provider module!"
      end
      say "Logging Event Types"
      logtypes = open("logtypes.txt")
      say logtypes.read
      @type = ask "? " do |q|
        q.default = "* -USERINPUT -USEROUTPUT -m_spanningtree"
      end
      say "Log Level"
      choose do |menu|
        menu.prompt = "What log level would you like to be at?"
        menu.choice(:default) do |m|
          @level = "default"
        end
        menu.choice(:debug) do |m|
          @level = "debug"
        end
        menu.choice(:sparse) do |m|
          @level = "sparse"
        end
        menu.choice(:verbose) do |m|
          @level = "verbose"
        end
      end
      say "Target: The file name where the log will be saved."
      @target = ask "? " do |q|
        q.default = "ircd.log"
      end
    end
    print
  end

  def print
    # <(exec)files>
    Kernel.print "<"
    if @exec == true
      Kernel.print("exec")
    end
    Kernel.print "files"
    puts "  motd=\"#{@motd}\""
    puts "  rules=\"#{@rules}\">"
    # <pid>
    puts "<pid file=\"#{@pid}\">"
    # <log>
    puts "<log method=\"#{@method}\" type=\"#{@type}\" level=\"#{@level}\" target=\"#{@target}\">"
    #puts "<log"
    #puts "  method=\"#{@method}\""
    #puts "  type=\"#{@type}\""
    #puts "  level=\"#{@level}\""
    #puts "  target=\"#{@target}\">"

  end
end
