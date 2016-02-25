$:.unshift File.dirname($0)

require "options"
require "security"
require "performance"
require "limits"
require "misctags"


class Ospl
  def initialize
    super
    Options.new
    Security.new
    Performance.new
    Limits.new
    Misc.new
  end
end

