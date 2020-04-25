module TrueSkill
  module Schedules
    class Step < Base

      @factor : TrueSkill::Factors::Base
      @index : Int32

      def initialize(factor, index)
        @factor = factor
        @index = index
      end

      def visit(depth = -1, max_depth = 0)
        @factor.update_message_at(@index)
      end
    end
  end
end
