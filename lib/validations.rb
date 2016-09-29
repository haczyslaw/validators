require File.expand_path("../validators/base_validator", __FILE__)
Dir["#{__dir__}/validators/*.rb"].each { |f| require f }

module Validations
  VALIDATION_SUFFIX = "validation_callback"

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validation_callbacks
      @validation_callbacks ||= Validations::Callbacks.new
    end

    # I can define this methods using array and each, but this version is much more readable

    def validates_presence_of(argument)
      callback_name = "_#{argument}_presence_#{VALIDATION_SUFFIX}".to_sym

      validation_callbacks.add(callback_name) do
        Validator::Presence.new(argument)
      end
    end

    def validates_numericality_of(argument)
      callback_name = "_#{argument}_numericality_#{VALIDATION_SUFFIX}".to_sym

      validation_callbacks.add(callback_name) do
        Validator::Numericality.new(argument)
      end
    end
  end

  class Callbacks
    def add(callback_name, &block)
      define_singleton_method(callback_name, &block)
    end

    def list
      @list ||= methods.grep(/_#{VALIDATION_SUFFIX}\Z/).map { |name| send(name) }
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
