module TrueSkill
  class FactorGraph
    # @return [Array<Array<TrueSkill::Rating>>]
    getter teams : Array(Array(TrueSkill::Rating))

    getter ranks : Array(Int32) | Array(Float64)

    # @return [Float]
    getter beta : Float64

    # @return [Float]
    getter beta_squared : Float64

    # @return [Float]
    getter draw_probability : Float64

    # @return [Float]
    getter epsilon : Float64

    getter layers : Array(TrueSkill::Layers::Base)

    # @return [Boolean]
    getter skills_additive : Bool

    # Creates a new trueskill factor graph for calculating the new skills based on the given game parameters
    #
    # @param [Array<Array<TrueSkill::Rating>>] teams
    #   player-ratings grouped in Arrays by teams
    # @param [Array<Integer>] ranks
    #   team rankings, example: [2,1,3] first team in teams finished 2nd, second team 1st and third team 3rd
    # @param [Hash] options
    #   the options hash to configure the factor graph constants beta, draw_probability and skills_additive
    #
    # @option options [Float] :beta (4.166667)
    #   the length of the skill-chain. Use a low value for games with a small amount of chance (Go, Chess, etc.) and
    #   a high value for games with a high amount of chance (Uno, Bridge, etc.)
    # @option options [Float] :draw_probability (0.1)
    #   how probable is a draw in the game outcome [0.0,1.0]
    # @option options [Boolean] :skills_additive (true)
    #   true is valid for games like Halo etc, where skill is additive (2 players are better than 1),
    #   false for card games like Skat, Doppelkopf, Bridge where skills are not additive,
    #         two players dont make the team stronger, skills averaged)
    #
    # @example Calculating new skills of a two team game, where one team has one player and the other two
    #
    #  require 'rubygems'
    #  require "saulabs/trueskill"
    #
    #  include Saulabs::TrueSkill
    #
    #  # team 1 has just one player with a mean skill of 27.1, a skill-deviation of 2.13
    #  # and a play activity of 100 %
    #  team1 = [Rating.new(27.1, 2.13, 1.0)]
    #
    #  # team 2 has two players
    #  team2 = [Rating.new(22.0, 0.98, 0.8), Rating.new(31.1, 5.33, 0.9)]
    #
    #  # team 1 finished first and team 2 second
    #  graph = FactorGraph.new( team1 => 1, team2 => 2 )
    #
    #  # update the Ratings
    #  graph.update_skills
    #
    def initialize(ranks_teams_hash : Hash(Array(TrueSkill::Rating), Int32 | Float64), options = Hash(Symbol, Float64 | Bool).new)
      @teams = ranks_teams_hash.keys
      @ranks = ranks_teams_hash.values
      @layers = Array(TrueSkill::Layers::Base).new

      b = options[:beta]?
      @beta = b.is_a?(Float64) ? b : 25/6.0
      @beta_squared = @beta**2

      d_p = options[:draw_probability]?
      @draw_probability = d_p.is_a?(Float64) ? d_p : 0.1

      s_a = options[:skills_additive]?
      @skills_additive = s_a.is_a?(Bool) ? s_a : true

      @epsilon = -Math.sqrt(2.0 * @beta_squared) * Gauss::Distribution.inv_cdf((1.0 - @draw_probability) / 2.0)

      # We unfortunately can't declare this ivar beforehand, since that causes a very weird bug.
      # This leads us to having to use .not_nil! every time we use it, since we know that it'll be
      # initialized, but Crystal doesn't.
      # If we do declare it, i.e. put @prior_layer : Layers::PriorToSkills with all the getters,
      # Crystal complains that @prior_layer was not initialized directly. I have not found any other
      # way to fix this, other than to not declare it, and thus allow it to be nil.
      @prior_layer = Layers::PriorToSkills.new(self, @teams)

      @layers = [
        @prior_layer.not_nil!,
        Layers::SkillsToPerformances.new(self),
        Layers::PerformancesToTeamPerformances.new(self, @skills_additive),
        Layers::IteratedTeamPerformances.new(self,
          Layers::TeamPerformanceDifferences.new(self),
          Layers::TeamDifferenceComparision.new(self, @ranks)
        )
      ]
    end

    def draw_margin
      Gauss::Distribution.inv_cdf(0.5*(@draw_probability + 1)) * Math.sqrt(1 + 1) * @beta
    end

    # Updates the skills of the players inplace
    #
    # @return [Float] the probability of the games outcome
    def update_skills
      # puts " vorher = #{@layers.map(&:input).inspect}}"
      build_layers
      run_schedule
      @teams.each_with_index do |team, i|
        team.each_with_index do |player, j|
          player.replace(@prior_layer.not_nil!.output[i][j])
        end
      end
      ranking_probability
    end

    private def ranking_probability
      # factor_list = []
      # sum_log_z, sum_log_s = 0.0
      # @layers.each do |layer|
      #   layer.factors.each do |factor|
      #     factor.reset_marginals
      #     factor.messages.each_index { |i| sum_log_z += factor.send_message_at(i) }
      #     sum_log_s += factor.log_normalization
      #   end
      # end
      # Math.exp(sum_log_z + sum_log_s)
      0.0
    end

    private def updated_skills
      @prior_layer.not_nil!.output
    end

    private def build_layers
      output = Array(Array(TrueSkill::Rating)).new
      @layers.each do |layer|
        layer.input = output
        layer.build
        output = layer.output
      end
    end

    private def run_schedule
      schedules = @layers.map &.prior_schedule + @layers.reverse.map &.posterior_schedule
      Schedules::Sequence.new(schedules.compact.map { |s| s.as(Schedules::Base) }).visit
    end
  end
end
