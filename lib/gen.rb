require "highline"
require "builder"


module Generator
  # Base class on Builder to use HighLine
  class Inspircd < Builder
    # Main InspIRCd interaction builder
    def self.main
      while agree("Want to make a block?", true)
        choose do |menu|
          menu.choice :conf, "Main Configuration" do |m|

          end
          menu.init_help
        end
      end
    end
  end
  class Unrealircd
    def self.main
      # ...
    end
  end
end
