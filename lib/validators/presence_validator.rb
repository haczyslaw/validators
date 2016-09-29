module Validator
  class Presence < Base
    MESSAGE = "can't be blank"

    def instance_is_valid?(instance)
      variable = instance.send(variable_name)
      variable.respond_to?(:empty?) ? !variable.empty? : variable
    end

    def tr_message # should be i18n
      MESSAGE
    end
  end
end
