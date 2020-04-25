require "../../spec_helper"

private def setup_factor
  variable = Gauss::Distribution.new

  TrueSkill::Factors::Prior.new(22.0, 0.3, variable)
end

describe TrueSkill::Factors::Prior do
  describe "#update_message_at" do
    it "should return a difference of 73.33333" do
      factor = setup_factor
      factor.update_message_at(0).should be_close(tolerance, 73.33333)
    end
  end

  describe "#log_normalization" do
    it "should be 0.0" do
      factor = setup_factor
      factor.log_normalization.should eq 0.0
    end
  end
end
