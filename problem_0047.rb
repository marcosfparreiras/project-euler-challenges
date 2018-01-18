# https://projecteuler.net/problem=47
#
# The first two consecutive numbers to have two distinct prime factors are:
# 14 = 2 x 7
# 15 = 3 x 5
#
# The first three consecutive numbers to have three distinct prime factors are:
# 644 = 2^2 x 7 × 23
# 645 = 3 × 5 × 43
# 646 = 2 × 17 × 19.
#
# Find the first four consecutive integers to have four distinct prime factors
# each. What is the first of these numbers?
#
# ANSWER: 134043
# This problem had a difficulty rating of 5%

require 'prime'
require 'benchmark'


module Problem0047
  class SolutionA
    def initialize(n_consecutive, n_primes, options = {})
      @n_consecutive = n_consecutive
      @n_primes = n_primes
      @max_value = options[:max_value] || 2**128
      @min_value = options[:min_value] || 0
    end

    def answer
      get_consecutives.first
    end

    private

    def get_consecutives
      consecutives = []
      (@min_value..@max_value).each do |n|
        if n_prime_factors(n) == @n_primes
          consecutives << n
          break if consecutives.size == @n_consecutive
        else
          consecutives = []
        end
      end
      consecutives
    end

    # how many prime factors the number has
    def n_prime_factors(number)
      n_prime = 0
      (2..number / 2).each do |n|
        next unless (number % n).zero?
        n_prime += 1 if Prime.prime?(n)
      end
      n_prime
    end
  end

  class SolutionB
    def initialize(n_consecutive, n_primes, options = {})
      @n_consecutive = n_consecutive
      @n_primes = n_primes
      @max_value = options[:max_value] || 2**128
      @min_value = options[:min_value] || 0
      @primes = []
    end

    def answer
      get_consecutives.first
    end

    private

    def get_consecutives
      consecutives = []
      (@min_value..@max_value).each do |n|
        if n_prime_factors(n) == @n_primes
          consecutives << n
          break if consecutives.size == @n_consecutive
        else
          consecutives = []
        end
      end
      consecutives
    end

    # how many prime factors the number has
    def n_prime_factors(number)
      detected_primes = n_detected_prime_fatores(number)

      start_factor = @primes.last ? @primes.last + 1 : 2
      not_detected_primes = n_not_detected_prime_factors(start_factor, number)
      detected_primes + not_detected_primes
    end

    def n_detected_prime_fatores(number)
      n_primes = 0
      @primes.each do |prime|
        n_primes += 1 if (number % prime).zero?
      end
      n_primes
    end

    def n_not_detected_prime_factors(start_factor, number)
      n_primes = 0
      (start_factor..number / 2).each do |n|
        next unless (number % n).zero?
        n_primes += 1 if Prime.prime?(n)
        @primes << n if Prime.prime?(n)
      end
      n_primes
    end
  end

  class BenchmarkAcrossSolutions
    def self.benchmark
      a33 = Problem0047::SolutionA.new(3, 3)
      a44 = Problem0047::SolutionA.new(4, 4)
      b33 = Problem0047::SolutionB.new(3, 3)
      b44 = Problem0047::SolutionB.new(4, 4)

      Benchmark.bm do |x|
        x.report(test_title('A', 3, 3)) { a33.answer }
        x.report(test_title('B', 3, 3)) { b33.answer }
        x.report(test_title('A', 4, 4)) { a44.answer }
        x.report(test_title('B', 4, 4)) { b44.answer }
      end
    end

    def self.test_title(solution, number_of_integers, number_of_primes)
      title = "#{solution} for #{number_of_integers} consecutive integers"
      title << " with #{number_of_primes} distinct prime factors"
    end
  end
end

# problem = Problem0047::SolutionA.new(3, 3)
# puts problem.answer
# => 644

# problem = Problem0047::SolutionB.new(3, 3)
# puts problem.answer
# => 644

# problem = Problem0047::SolutionA.new(4, 4)
# puts problem.answer
# => 134043

# problem = Problem0047::SolutionB.new(4, 4)
# puts problem.answer
# => 134043

# For getting the answer for 3 consecutive integers with 3 prime factors, both
# solutions work well. However, for getting the first 4 consecutive integers
# with 4 prime factors, the solution A takes too long. The following
# benchmark shows how betteris the Solution B compared to the Solution A
Problem0047::BenchmarkAcrossSolutions.benchmark
#       user                                                system       total        real
#A for 3 consecutive integers with 3 distinct prime factors   0.010000   0.000000   0.010000 (  0.009550)
#B for 3 consecutive integers with 3 distinct prime factors   0.000000   0.000000   0.000000 (  0.002511)
#A for 4 consecutive integers with 4 distinct prime factors 252.870000   0.000000 252.870000 (252.878916)
#B for 4 consecutive integers with 4 distinct prime factors  27.230000   0.000000  27.230000 ( 27.224640)
