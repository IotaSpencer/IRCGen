require "generator"
class Oper < Builder
  attr_accessor :name, :hosts, :pass, :type #Required
  attr_accessor :wants_hash, :hash
  attr_accessor :wants_swhois, :swhois # Optional
  attr_accessor :sslonly, :wants_fingerprint, :fingerprint #Extremely Optional though secure.

  def initialize
    super
    STDERR.puts "You have selected the InspIRCd opers.conf generator"

    say "Name of the oper.. 'bob' 'Iota' as an example."
    say "Case does count, so 'iota' 'IOTA' 'Iota' 'IoTa' are all different"
    @name = ask "Name?" do |q|
      q.default       = "MiScOnFiGuReD OpEr"
      q.gather        = 2
      q.verify_match  = true
    end
    if @name == "MiScOnFiGuReD OpEr"
      exit 1
    end
    say "What hosts will this oper be connecting from."
    say "Your input should be"
    say "user1@host1"
    say "user2@host2"
    say "user3@host3"
    say "..."
    say "To end, enter a blank newline."
    @hosts = ask "?" do |q|
      q.gather = ""
    end
    if agree(" do you want to use a hash?", true)
      @wants_hash = true
      choose do |menu|
        menu.prompt = "What hash do you want to use?"
        menu.choice(:sha256, "Recommended") do |m|
          say("Alright, that's saved as your hash choice.")
          @hash = "sha256"
        end
        menu.choice(:md5, "Easy but insecure.") do |m|
          say("Alright, that's saved as your hash choice.")
          @hash = "md5"
        end
        menu.choice(:ripemd160, "If you don't want sha256 then pick this one.") do |m|
          say("Alright, that's saved as your hash choice.")
          @hash = "ripemd160"
        end
      end
    end
    puts @hash
    puts @wants_hash
    say "Now I need the password you want."
    if @wants_hash
      say "Since you answered #{@wants_hash} to whether you wanted a hash, and you picked #{@hash}, you're going to enter that string into this next question."
    else
      say "Since you said you don't want a hash you're using a non-secure string, just enter the string here."
    end
    @pass = ask "?" do |q|
      q.echo = "*"
      q.gather = 2
      q.verify_match = true
    end
    say "Should this oper get a swhois?"
    say "If you want:"
    say "Oper is a dinosaur"
    say "Then enter 'is a dinosaur'"

    if agree(" do you want a swhois for this oper? ", true)
      @swhois = ask "What should the swhois be." do |q|
        q.confirm = true
      end
    else
      @wants_swhois = nil
      @swhois = ""
    end

    @sslonly = agree(" do you want to require \"#{@name}\" connect via SSL (Secure Socket Layers) to be able to /oper? ", true)

    if agree(" do you want to add #{@name}'s SSL fingerprint? ", true)
      @fingerprint = ask "What is #{@name}'s fingerprint? " do |q|
        @wants_fingerprint = true
      end
    else
      @wants_fingerprint = nil
      @fingerprint = ""
    end
    say "For the Oper Type, if you already have the types set up, then put the one you want #{@name} to fall under. Spaces will be converted into underscores for the config."
    @type = ask("What Oper type is #{@name} under? ")
    if @type.include? " "
      @type.gsub! " ", "_"
    end
    print
  end

  def print
    puts "<oper name=\"#{@name}\"",
          "  host=\"#{@hosts.join(" ")}\"",
          "  password=\"#{@pass}\""
    if @wants_hash
      puts "  hash=\"#{@hash.to_s}\""
    end
    if @wants_swhois
      puts "  swhois=\"#{@swhois}\""
    end
    puts "  sslonly=\"#{@sslonly}\""
    if @wants_fingerprint
      puts "  fingerprint=\"#{@fingerprint}\""
    end
    puts "  type=\"#{@type}\">"
  end
end
