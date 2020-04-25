require "../../spec_helper"

private def setup_factor
  variable = Gauss::Distribution.with_variance(0.0, 0.0)
    variables = [
      Gauss::Distribution.new(22, 1.6),
      Gauss::Distribution.new(26, 2.5),
      Gauss::Distribution.new(31, 3.6),
    ]

    TrueSkill::Factors::WeightedSum.new(variable, variables, [0.5, 0.7, 0.8])
end

describe TrueSkill::Factors::Prior do
  describe "weights" do
    it "should setup the weights correctly" do
      factor = setup_factor
      factor.weights[0][0].should be_close(tolerance, 0.5)
      factor.weights[1][0].should be_close(tolerance, -1.4)
      factor.weights[2][0].should be_close(tolerance, -0.7142)
      factor.weights[2][1].should be_close(tolerance, -1.14285)
      factor.weights[3][0].should be_close(tolerance, -0.625)
      factor.weights[3][2].should be_close(tolerance, 1.25)
    end
  end

  describe "weights_squared" do
    it "should setup the squared weights correctly" do
      factor = setup_factor
      factor.weights_squared[0][0].should be_close(tolerance, 0.25)
      factor.weights_squared[1][0].should be_close(tolerance, 1.96)
      factor.weights_squared[2][0].should be_close(tolerance, 0.51)
      factor.weights_squared[2][1].should be_close(tolerance, 1.3061)
      factor.weights_squared[3][0].should be_close(tolerance, 0.3906)
      factor.weights_squared[3][2].should be_close(tolerance, 1.5625)
    end
  end

  describe "index_order" do
    it "should setup the index order correctly" do
      factor = setup_factor
      factor.index_order[0][0].should eq 0
      factor.index_order[1][0].should eq 1
      factor.index_order[2][0].should eq 2
      factor.index_order[2][1].should eq 1
      factor.index_order[2][2].should eq 3
      factor.index_order[3][1].should eq 1
    end
  end

  describe "#update_message_at" do
    it "should return a difference of 4.50116 for message 0" do
      factor = setup_factor
      factor.update_message_at(0).should be_close(tolerance, 4.50116)
    end
  end
end
