# Link for the problem: https://projecteuler.net/problem=1
# Multiples of 3 and 5
# Problem 1

# If we list all the natural numbers below 10 that are multiples of 3 or 5
# get 3, 5, 6 and 9. The sum of these multiples is 23.
# Find the sum of all the multiples of 3 or 5 below 1000.

# ANSWER: 233168

require 'benchmark'

class Problem0001
  def self.version1(initial = 0, final = 999)
    (initial..final).inject(0) do |sum, i|
      (i % 3).zero? || (i % 5).zero? ? sum + i : sum
    end
  end

  def self.version2(initial = 0, final = 999)
    (initial..final).select { |i| (i % 3).zero? || (i % 5).zero? }.reduce(&:+)
  end

  def self.versions_benchmark
    Benchmark.bm do |x|
      x.report('version1 up to 1e3') { version1(0, 1_000) }
      x.report('version2 up to 1e3') { version2(0, 1_000) }
      x.report('version1 up to 1e6') { version1(0, 1_000_000) }
      x.report('version2 up to 1e6') { version2(0, 1_000_000) }
      x.report('version1 up to 1e9') { version1(0, 1_000_000_000) }
      x.report('version2 up to 1e0') { version2(0, 1_000_000_000) }
    end
  end
end

result_v1 = Problem0001.version1(0, 999)
puts result_v1
# => 233168

result_v2 = Problem0001.version2(0, 999)
puts result_v2
# => 233168

Problem0001.versions_benchmark
# user                system      total      real
# version1 up to 1e3  0.000000    0.000000   0.000000 (  0.000129)
# version2 up to 1e3  0.000000    0.000000   0.000000 (  0.000164)
# version1 up to 1e6  0.100000    0.000000   0.100000 (  0.099784)
# version2 up to 1e6  0.120000    0.000000   0.120000 (  0.118132)
# version1 up to 1e9  101.130000  0.000000 101.130000 (101.135491)
# version2 up to 1e0  121.250000  0.810000 122.060000 (122.888835)

# - As one can see, both versions lead to the same result: 233168
# - The benchmark was done to compare their performances and after seeing the
# results, we can infer that the version 1 is better then the version 2.
# - The main reason for this is that the version 1 goes through the array only
# once, whereas the version 2 goes through the array once to select the elements
# and then it goes through the whole new array of elements.
