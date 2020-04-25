module TrueSkill
  module Layers
    class IteratedTeamPerformances < Base

      @tpd : TrueSkill::Layers::Base
      @tdc : TrueSkill::Layers::Base

      def initialize(graph, team_perf_diff, team_diff_comp)
        super(graph)
        @tpd = team_perf_diff
        @tdc = team_diff_comp
      end

      def build
        @tpd.input = @input
        @tpd.build
        @tdc.input = @tpd.output
        @tdc.build
      end

      def factors
        @tpd.factors + @tdc.factors
      end

      def prior_schedule
        loop_schedule = if @input.size == 2
                          two_team_loop_schedule
                        elsif @input.size > 2
                          multiple_team_loop_schedule
                        else
                          raise "Illegal input"
                        end
        team_diffs = @tpd.factors.size
        Schedules::Sequence.new([loop_schedule,
                                 Schedules::Step.new(@tpd.factors[0], 1).as(Schedules::Base),
                                 Schedules::Step.new(@tpd.factors[team_diffs - 1], 2).as(Schedules::Base)])
      end

      private def two_team_loop_schedule
        Schedules::Sequence.new([
          Schedules::Step.new(@tpd.factors[0], 0).as(Schedules::Base),
          Schedules::Step.new(@tdc.factors[0], 0).as(Schedules::Base),
        ])
      end

      def multiple_team_loop_schedule
        team_diff = @tpd.factors.size
        forward_schedule = Schedules::Sequence.new(
          (0..team_diff - 2).map { |i|
            Schedules::Sequence.new([
              Schedules::Step.new(@tpd.factors[i], 0).as(Schedules::Base),
              Schedules::Step.new(@tdc.factors[i], 0).as(Schedules::Base),
              Schedules::Step.new(@tpd.factors[i], 2).as(Schedules::Base),
            ]).as(Schedules::Base)
          })
        backward_schedule = Schedules::Sequence.new(
          (0..team_diff - 2).map { |i|
            Schedules::Sequence.new([
              Schedules::Step.new(@tpd.factors[team_diff - 1 - i], 0).as(Schedules::Base),
              Schedules::Step.new(@tdc.factors[team_diff - 1 - i], 0).as(Schedules::Base),
              Schedules::Step.new(@tpd.factors[team_diff - 1 - i], 1).as(Schedules::Base),
            ]).as(Schedules::Base)
          })
        Schedules::Loop.new(Schedules::Sequence.new([forward_schedule.as(Schedules::Base), backward_schedule.as(Schedules::Base)]), 0.0001)
      end
    end
  end
end
