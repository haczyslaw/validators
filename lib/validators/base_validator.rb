module Validator
  DEFAULT_MESSAGE = "invalid value"

  class Base
    attr_accessor :variable_name

    def initialize(variable_name)
      @variable_name = variable_name
    end

    def error_message
      "#{variable_name} #{tr_message}"
    end

    def tr_message
      DEFAULT_MESSAGE
    end
  end
end
