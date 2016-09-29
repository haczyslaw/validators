# TASK: Implement this class to make tests pass
require File.expand_path("../lib/validators/base_validator", __FILE__)
Dir[("#{__dir__}/lib/validators/*.rb")].each { |f| require f }

class BaseClass

  def self.validation_callbacks
    @validation_callbacks ||= Callbacks.new
  end

  def self.validates_presence_of(argument)
    callback_name = "_#{argument}_presence_validation_callback".to_sym
    validation_callbacks.add(callback_name) do
      Validator::Presence.new(argument)
    end
  end

  def self.validates_numericality_of(argument)
    callback_name = "_#{argument}_numericality_validation_callback".to_sym
    validation_callbacks.add(callback_name) do
      Validator::Numericality.new(argument)
    end
  end

  class Callbacks
    def add(callback_name, &block)
      define_singleton_method(callback_name, &block)
    end

    def list
      @list ||= methods.grep(/_validation_callback/).map { |name| send(name) }
    end
  end

  def valid?
    callbacks = self.class.validation_callbacks.list
    callbacks.each do |validator|
      errors << validator.error_message unless validator.instance_is_valid?(self)
    end

    errors.empty?
  end

  def errors
    @errors ||= []
  end
end
