module TrueSkill
  module Schedules
    abstract class Base
      abstract def visit(depth = -1, max_depth = 0)
    end
  end
end
