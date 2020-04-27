require "../spec_helper"
require "../true_skill_matchers"

teams = Array(Array(TrueSkill::Rating)).new
skill = TrueSkill::Rating.new(25, 2.5)
results = Hash(Array(TrueSkill::Rating), Int32).new
graph = TrueSkill::FactorGraph.new(results)

describe TrueSkill::FactorGraph, "Unit Tests" do
  before_each do
    teams = create_teams
    skill = teams[0][0]
    results = {teams[0] => 1, teams[1] => 2, teams[2] => 3}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills" do
    it "should update the mean of the first player in team1 to 30.38345" do
      graph.not_nil!
      graph.update_skills
      skill.mean.should be_close(30.38345, tolerance)
    end

    # it "should update the deviation of the first player in team1 to 3.46421" do
      # graph.not_nil!
      # graph.update_skills
      # skill.deviation.should be_close(3.46421, tolerance)
    # end
  end

  # describe "#draw_margin" do
    # it "should be -0.998291 for diff 0.740466" do
      # graph.not_nil!
      # graph.draw_margin.should be_close(0.740466, tolerance)
    # end
  # end
end

# describe TrueSkill::FactorGraph, "Integration Tests" do
  # context "When there are two teams" do
    # Each team needs unique instances as we modify by side effect
    # team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]

    # Each team needs unique instances as we modify by side effect
    # team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]

    # teams = [team1, team2]

    # results = {team1 => 1, team2 => 2}

    # draw_results = {team1 => 1, team2 => 1}

    # context "and exactly two players" do
      # describe "team1 win with standard rating" do
        # before_each do
          # TrueSkill::FactorGraph.new(results).update_skills
        # end

        # it "should change first players rating to [29.395832, 7.1714755]" do
          # teams[0][0].should TrueSkillMatchers.eql_rating(29.395832, 7.1714755)
        # end

        # it "should change second players rating to [20.6041679, 7.1714755]" do
          # teams[1][0].should TrueSkillMatchers.eql_rating(20.6041679, 7.1714755)
        # end
      # end
    # end

    # describe "draw with standard rating" do
      # before_each do
        # TrueSkill::FactorGraph.new(draw_results).update_skills
      # end

      # it "should change first players rating to [25.0, 6.4575196]" do
        # teams[0][0].should TrueSkillMatchers.eql_rating(25.0, 6.4575196)
      # end

      # it "should change second players rating to [25.0, 6.4575196]" do
        # teams[1][0].should TrueSkillMatchers.eql_rating(25.0, 6.4575196)
      # end
    # end

    # describe "draw with different ratings" do
      # team2 = [TrueSkill::Rating.new(50.0, 12.5, 1.0, 25.0/300.0)]

      # before_each do
        # TrueSkill::FactorGraph.new(draw_results).update_skills
      # end

      # it "should change first players rating to [31.6623, 7.1374]" do
        # teams[0][0].should TrueSkillMatchers.eql_rating(31.662301, 7.1374459)
      # end

      # it "should change second players mean to [35.0107, 7.9101]" do
        # teams[1][0].should TrueSkillMatchers.eql_rating(35.010653, 7.910077)
      # end
    # end

    # context "when it is a 1 vs 2" do
      # team2 = [
                # TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0),
                # TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0),
              # ]

      # context "and the skills are additive" do
        # describe "#@skill_update" do
          # it "should have a Boolean @skills_additive = false" do
            # graph = TrueSkill::FactorGraph.new(draw_results, {:skills_additive => false})
            # graph.skills_additive.should be_false
          # end

          # it "should update the mean of the first player in team1 to 25.0 after draw" do
            # graph = TrueSkill::FactorGraph.new(draw_results, {:skills_additive => false})

            # graph.update_skills
            # teams[0][0].mean.should be_close(25.0, tolerance)
          # end
        # end
      # end
    # end
  # end
# end
