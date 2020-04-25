module TrueSkill
  module Layers
    class PriorToSkills < Base
      @teams : Array(Array(TrueSkill::Rating))

      def initialize(graph, teams)
        super(graph)
        @teams = teams
      end

      def build
        @teams.each do |team|
          team_skills = Array(TrueSkill::Rating).new
          team.each do |rating|
            variable = TrueSkill::Rating.new(0.0, 0.0, rating.activity, rating.tau)
            @factors << Factors::Prior.new(rating.mean, rating.variance + rating.tau_squared, variable)
            team_skills << variable
          end
          @output << team_skills
        end
      end

      def prior_schedule
        Schedules::Sequence.new(@factors.map { |f| Schedules::Step.new(f, 0).as(Schedules::Base) })
      end
    end
  end
end
