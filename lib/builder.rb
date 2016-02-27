require "highline"

  # Extends the use of HighLine, acting as if +require "highline/import"+ was used
  # @see http://www.rubydoc.info/gems/highline/HighLine
class Builder
  @@a = HighLine.new($stdin,$stderr,80,nil,3,3)

  # @param question [String] Question to be asked
  # @param character [Boolean] Whether to take the first character entered
  def agree(question, character)
    @@a.agree(*args)
  end

  # @param question [String] Question to be asked
  # @param args any other options that need to be asked
  # @param block [Proc] Allows fine tuning of validation etc.
  def ask(question, *args, &block)
    @@a.ask(question, *args, &block)
  end

  # @param statement [Statement, String] String or Statement to output
  def say(statement)
    @@a.say(statement)
  end

  # @param items [Array, nil] Used for a quick and dirty selection
=begin
@param details [Proc] When passed, a HighLine::Menu instance is brought along, allowing a more fine tuned look
=end
  def choose(*items, &details)
    @@a.choose(*items, &details)
  end
end
# vim: sw=2 ts=2 expandtab
