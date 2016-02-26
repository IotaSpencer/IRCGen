require "highline"
require "builder"


module Generator
  #
  class Inspircd < Builder
    def self.main
      while agree("Want to make a block?", true)
        choose do |menu|
          menu.choice :conf, "Main Configuration" do |m|

          menu.init_help
        end
      end
    end
  end
  class Unrealircd
    def self.main
    end
  end
end
