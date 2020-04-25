require "../spec_helper"

describe "Schedules" do
  it "should do something" do
    factor = TrueSkill::Factors::Prior.new(25.0, (25/3.0)**2, Gauss::Distribution.new)
    step = TrueSkill::Schedules::Step.new(factor, 0)
    step.visit
  end
end
