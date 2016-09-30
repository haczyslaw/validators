require File.expand_path("../validators/base_validator", __FILE__)
Dir["#{__dir__}/validators/*.rb"].each { |f| require f }

module Validations

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def validation_callbacks
      @validation_callbacks ||= Validations::Callbacks.new
    end

    # I can define this methods using array and each, but this version is much more readable

    def validates_presence_of(argument)
      validation_callbacks.add(Validator::Presence.new(argument))
    end

    def validates_numericality_of(argument)
      validation_callbacks.add(Validator::Numericality.new(argument))
    end
  end

  class Callbacks
    attr_reader :list

    def add(callback)
      @list ||= []
      @list << callback
    end
  end

  def valid?
    # ToDo: We should write test in case of revalidation, but I can't touch test file ;)
    @errors = []

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
