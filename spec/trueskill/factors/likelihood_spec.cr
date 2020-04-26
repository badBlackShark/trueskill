require "../../spec_helper"

private def setup_factor
  variable1 = Gauss::Distribution.new(26, 1.1)
  variable2 = Gauss::Distribution.new

  TrueSkill::Factors::Likelihood.new(30, variable1, variable2)
end

describe TrueSkill::Factors::Likelihood do
  describe "#update_message_at" do
    it "should return a difference of 0.0" do
      factor = setup_factor
      factor.update_message_at(0).should be_close(0.0, tolerance)
    end

    it "should return a difference of 0.833066 for the second message" do
      factor = setup_factor
      factor.update_message_at(0)
      factor.update_message_at(1).should be_close(0.833066, tolerance)
    end
  end

  describe "#log_normalization" do
    it "should be 0.0" do
      factor = setup_factor
      factor.log_normalization.should eq 0.0
    end
  end
end
