require "highline"

class Builder
  @@a = HighLine.new($stdin,$stderr,80,nil,3,3)

  def say(*args)
  # params:
    @@a.say(*args)
  end

  def ask(*args, &block)
    @@a.ask(*args, &block)
  end

  def agree(*args)
    @@a.agree(*args)
  end

  def choose(*args, &block)
    @@a.choose(*args, &block)
  end
end
# vim: sw=2 ts=2 expandtab
