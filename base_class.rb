# TASK: Implement this class to make tests pass
class BaseClass

  def self.validation_callbacks
    @validation_callbacks ||= Callbacks.new
  end

  def self.validates_presence_of(argument)
    callback_name = "_#{argument}_presence_validation_callback".to_sym
    validation_callbacks.add(callback_name) do
      # Add validator here
    end
  end

  def self.validates_numericality_of(argument)
    callback_name = "_#{argument}_numericality_validation_callback".to_sym
    validation_callbacks.add(callback_name) do
      # Add validator here
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
end
