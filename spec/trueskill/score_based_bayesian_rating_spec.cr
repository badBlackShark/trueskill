require "../spec_helper"

team1 = nil
team2 = nil
teams = nil
skill = nil
results = nil
graph = nil

describe "TrueSkill::ScoreBasedBayesianRating: 2 vs 2: team 1=> 1.0, team2 => -1.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => 1.0, team2 => -1.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 2 vs 2: team 1=> -1.0, team2 => 1.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => -1.0, team2 => 1.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 1 vs 3: team1 => -1.0, team2 => 1.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => -1.0, team2 => 1.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 1 vs 3: team1 => 1.0, team2 => -1.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => 1.0, team2 => -1.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 1 vs 3: team1 => 100.0, team2 => -100.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => 100.0, team2 => -100.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 1 vs 3: team1 => -100.0, team2 => 100.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => -100.0, team2 => 100.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 1 vs 3: Draw: team1 => 100.0, team2 => 100.0" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 1.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => 100.0, team2 => 100.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should_not be_close(tolerance, 25.0)
    end
  end
  describe "#update_skills " do
    it "should update the mean of the first player in team1: skills additive => false" do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10, :skills_additive => false})
      test.update_skills
      teams[0][0].mean.should be_close(tolerance, 25.0)
    end
  end
end

describe "TrueSkill::ScoreBasedBayesianRating: 1 vs 3: Draw: team1 => 100.0, team2 => 100.0, Test partial update" do
  before_each do
    team1 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 0.0, 25.0/300.0)]
    team2 = [TrueSkill::Rating.new(25.0, 25.0/3.0, 0.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 0.0, 25.0/300.0), TrueSkill::Rating.new(25.0, 25.0/3.0, 0.0, 25.0/300.0)]
    teams = [team1, team2]
    skill = teams[0][0]
    results = {team1 => 100.0, team2 => 100.0}
    graph = TrueSkill::FactorGraph.new(results)
  end

  describe "#update_skills " do
    it "should update the mean of the first player in team1: " do
      test = TrueSkill::ScoreBasedBayesianRating.new(results, {:gamma => 1, :beta => 10})
      test.update_skills
      teams[0][0].mean.should be_close(tolerance, 25.0)
    end
  end
end
