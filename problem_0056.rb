# https://projecteuler.net/problem=56
#
# Powerful digit sum
# Problem 56
#
# A googol (10**100) is a massive number: one followed by one-hundred zeros;
# 100**100 is almost unimaginably large: one followed by two-hundred zeros.
# Despite their size, the sum of the digits in each number is only 1.
#
# Considering natural numbers of the form, ab, where a, b < 100, what is the
# maximum digital sum?
#
# ANSWER: 972

class Problem0056
  attr_reader :max_sum, :max_sum_value

  def initialize
    @max_sum = 0
    @max_sum_value = 0
  end

  def answer
    calculate
    @max_sum
  end

  private

  def calculate
    (0...100).each do |a|
      (0...100).each do |b|
        value = a**b
        digits_sum = value.to_s.chars.map(&:to_i).reduce(:+)
        next unless digits_sum > @max_sum
        @max_sum = digits_sum
        @max_sum_value = value
      end
    end
  end
end

problem = Problem0056.new
puts problem.answer
# => 972

puts problem.max_sum_value
# Wrapped response
# => 384896078893484861192779580282459678960845115608736603465862795353014812600
# 853425803226738376862748709461096855428669269737472672585319565767946059023963
# 6893953692985541958490801973870359499
