require "../../spec_helper"

private def setup_factor
  variable = Gauss::Distribution.new(1.0, 1.1)

  TrueSkill::Factors::Within.new(0.01, variable)
end

describe TrueSkill::Factors::Within do
  describe "#update_message_at" do
    it "should return a difference of 173.2048" do
      factor = setup_factor
      factor.update_message_at(0).should be_close(tolerance, 173.2048)
    end
  end

  describe "#log_normalization" do
    it "should be -5.339497" do
      factor = setup_factor
      factor.log_normalization.should be_close(tolerance, -5.339497)
    end
  end
end
