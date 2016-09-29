module Validator
  class Numericality < Base
    MESSAGE = "must be number"

    def instance_is_valid?(instance)
      variable = instance.send(variable_name)
      variable.is_a? Integer
    end

    def tr_message # should be i18n
      MESSAGE
    end
  end
end
