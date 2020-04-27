module Gauss
  # Implementation of a gaussian distribution
  class Distribution
    @@sqrt2 : Float64 = Math.sqrt(2)
    @@inv_sqrt_2pi : Float64 = (1 / Math.sqrt(2 * Math::PI))
    @@log_sqrt_2pi : Float64 = Math.log(Math.sqrt(2 * Math::PI))

    # gaussian normal distribution values
    property mean : Float64
    property deviation : Float64
    property variance : Float64
    property precision : Float64
    property precision_mean : Float64

    def initialize(mean = 0.0, deviation = 0.0)
      mean = 0.0 unless mean.to_f.finite?
      deviation = 0.0 unless deviation.to_f.finite?
      @mean = mean.to_f
      @deviation = deviation.to_f
      @variance = @deviation * @deviation
      @precision = deviation == 0.0 ? 0.0 : 1 / @variance.to_f
      @precision_mean = @precision * mean
    end

    def self.standard
      Distribution.new(0.0, 1.0)
    end

    def self.with_deviation(mean, deviation)
      Distribution.new(mean, deviation)
    end

    def self.with_variance(mean, variance)
      Distribution.new(mean, Math.sqrt(variance))
    end

    def self.with_precision(mean, precision)
      Distribution.new(mean / precision, Math.sqrt(1 / precision))
    end

    def self.absolute_difference(x, y)
      [(x.precision_mean - y.precision_mean).abs, Math.sqrt((x.precision - y.precision).abs)].max
    end

    def self.log_product_normalization(x, y)
      return 0.0 if x.precision == 0.0 || y.precision == 0.0
      variance_sum = x.variance + y.variance
      mean_diff = x.mean - y.mean
      -@@log_sqrt_2pi - (Math.log(variance_sum) / 2.0) - (mean_diff**2 / (2.0 * variance_sum))
    end

    def self.log_ratio_normalization(x, y)
      return 0.0 if x.precision == 0.0 || y.precision == 0.0
      variance_diff = y.variance - x.variance
      return 0.0 if variance_diff == 0.0
      mean_diff = x.mean - y.mean
      Math.log(y.variance) + @@log_sqrt_2pi - (Math.log(variance_diff) / 2.0) + (mean_diff**2 / (2.0 * variance_diff))
    end

    # Computes the cummulative Gaussian distribution at a specified point of interest
    # Cumulative distribution function
    def self.cdf(x)
      0.5 * (1 + Math.erf(x / @@sqrt2))
    end

    # Computes the Gaussian density at a specified point of interest
    # Probability density function
    def self.pdf(x)
      @@inv_sqrt_2pi * Math.exp(-0.5 * (x**2))
    end

    # The inverse of the cummulative Gaussian distribution function
    # Quantile function
    def self.inv_cdf(x)
      -@@sqrt2 * inv_erf(2.0 * x)
    end

    def self.inv_erf(p)
      return -100 if p >= 2.0
      return 100 if p <= 0.0

      pp = p < 1.0 ? p : 2 - p
      t = Math.sqrt(-2*Math.log(pp/2.0)) # Initial guess
      x = -0.70711*((2.30753 + t*0.27061)/(1.0 + t*(0.99229 + t*0.04481)) - t)

      [0, 1].each do |j|
        err = erf(x) - pp
        x += err/(1.12837916709551257*Math.exp(-(x*x)) - x*err) # Halley
      end
      p < 1.0 ? x : -x
    end

    def self.erf(x)
      Math.erfc(x)
    end

    def value_at(x)
      exp = -((x - @mean)**2.0 / (2.0 * @variance))
      (1.0/@deviation) * @@inv_sqrt_2pi * Math.exp(exp)
    end

    # copy values from other distribution
    def replace(other)
      @precision = other.precision
      @precision_mean = other.precision_mean
      @mean = other.mean
      @deviation = other.deviation
      @variance = other.variance
    end

    def *(other)
      Distribution.with_precision(self.precision_mean + other.precision_mean, self.precision + other.precision)
    end

    def /(other)
      Distribution.with_precision(self.precision_mean - other.precision_mean, self.precision - other.precision)
    end

    # absolute difference
    def -(other)
      Distribution.absolute_difference(self, other)
    end

    def +(other)
    end

    def ==(other)
      self.mean == other.mean && self.variance == other.variance
    end

    def equals(other)
      self == other
    end

    def to_s
      "[μ=#{"%.4f" % mean}, σ=#{"%.4f" % deviation}]"
    end

    def_clone
  end
end
