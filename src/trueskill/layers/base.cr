module TrueSkill
  module Layers
    abstract class Base
      property graph : TrueSkill::FactorGraph
      property factors : Array(TrueSkill::Factors::Base)
      property output : Array(Array(TrueSkill::Rating)) | Array(Array(Gauss::Distribution))
      property input : Array(Array(TrueSkill::Rating)) | Array(Array(Gauss::Distribution))

      def initialize(graph)
        @graph = graph
        @factors = Array(TrueSkill::Factors::Base).new
        @output = Array(Array(TrueSkill::Rating)).new
        @input = Array(Array(TrueSkill::Rating)).new
      end

      abstract def build

      def prior_schedule
        nil
      end

      def posterior_schedule
        nil
      end
    end
  end
end
