module TrueSkill
  module Layers
    class TeamPerformanceDifferences < Base
      def initialize(graph)
        super(graph)
      end

      def build
        (0..@input.size - 2).each do |i|
          variable = Gauss::Distribution.new
          @factors << Factors::WeightedSum.new(variable, [@input[i][0], @input[i + 1][0]], [1.0, -1.0])
          @output << [TrueSkill::Rating.new(0.0, 0.0)]
        end
      end
    end
  end
end
