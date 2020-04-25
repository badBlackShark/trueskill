module TrueSkill
  module Factors
    abstract class Base
      def initialize
        @messages = Array(Gauss::Distribution).new
        @bindings = Hash(Gauss::Distribution, Gauss::Distribution).new
        @variables = Array(Gauss::Distribution).new
        @priors = Array(Gauss::Distribution).new
      end

      abstract def update_message_at(index)

      def message_count
        @messages.size
      end

      abstract def log_normalization

      def reset_marginals
        @bindings.values.each { |var| var.replace(Gauss::Distribution.new) }
      end

      def send_message_at(idx)
        message = @messages[idx]
        variable = @variables[idx]
        log_z = Gauss::Distribution.log_product_normalization(message, variable)
        variable.replace(message * variable)
        return log_z
      end

      def bind(variable)
        message = Gauss::Distribution.new
        @messages << message
        @bindings[message] = variable
        @variables << variable
        return message
      end
    end
  end
end
