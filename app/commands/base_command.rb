# frozen_string_literal: true

# Base Command class that every other command class inherits from. It
# implements the basic command pattern: each command will return an instance of
# themselves after a payload function is called; also each of them will publish
# an `errors`, `success` and `success?` method.
class BaseCommand
  attr_reader :result

  def self.call(*args)
    new(*args).call
  end

  def call
    @result = nil
    payload
    self
  end

  def success?
    errors.empty?
  end

  def errors
    @errors ||= ActiveModel::Errors.new(self)
  end

  private

  # rubocop:disable Naming/UncommunicativeMethodParamName
  def initialize(*_)
    not_implemented
  end
  # rubocop:enable Naming/UncommunicativeMethodParamName

  def payload
    not_implemented
  end
end
