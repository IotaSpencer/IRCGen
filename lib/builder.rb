require "highline"

  # Extends the use of HighLine, acting as if +require "highline/import"+ was used
  # @see http://www.rubydoc.info/gems/highline/HighLine
class Builder
  @@a = HighLine.new($stdin,$stderr,80,nil,3,3)

  # @param question [String] Question to be asked
  # @param character [Boolean] Whether or not we take the first character entered
  def agree(question, character)
    @@a.agree(*args)
  end

  # @param question [String] Question to be asked
  # @param *args any other options that need to be asked
  # @param &block Passing a block a
  def ask(question, *args, &block)
    @@a.ask(*args, &block)
  end

  def say(*args)
    @@a.say(*args)
  end

  def choose(*args, &block)
    @@a.choose(*args, &block)
  end
end
# vim: sw=2 ts=2 expandtab
