require "spec"
require "../src/trueskill"
require "./true_skill_matchers"

# Spec.configure do |config|
#   config.include(TrueSkillMatchers)
# end

def tolerance
  0.001
end

def create_teams
  team1 = [TrueSkill::Rating.new(25, 4.1)]
  team2 = [TrueSkill::Rating.new(27, 3.1), TrueSkill::Rating.new(10, 1.0)]
  team3 = [TrueSkill::Rating.new(32, 0.2)]
  [team1, team2, team3]
end
