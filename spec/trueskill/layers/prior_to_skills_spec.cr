require "../../spec_helper"

private def layer_setup
  teams = create_teams
  results = Hash(Array(TrueSkill::Rating), Int32).new
  results[teams[0]] = 1
  results[teams[1]] = 2
  results[teams[2]] = 3
  graph = TrueSkill::FactorGraph.new(results)

  TrueSkill::Layers::PriorToSkills.new(graph, teams)
end

describe TrueSkill::Layers::PriorToSkills do

  describe "#build" do
    it "should add 4 factors" do
      layer = layer_setup
      size_before = layer.factors.size
      layer.build
      layer.factors.size.should eq size_before + 4
    end

    it "should add 3 output variables" do
      layer = layer_setup
      size_before = layer.factors.size
      layer.build
      layer.factors.size.should eq size_before + 3
    end
  end

  describe "#prior_schedule" do
    it "should return a sequence-schedule" do
      layer = layer_setup
      layer.build
      layer.prior_schedule.should be_a(TrueSkill::Schedules::Sequence)
    end
  end
end
