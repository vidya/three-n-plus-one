
# http://acm.cs.buap.mx/downloads/Programming_Challenges.pdf

# 1.6.1 The 3n+ 1 Problem
#  
# PC/UVa IDs: 110101/100, Popularity: A, Success rate: low Level: 1
#
# Consider the following algorithm to generate a sequence of numbers. Start with an
# integer n. If n is even, divide by 2. If n is odd, multiply by 3 and add 1. Repeat this
# process with the new value of n, terminating when n = 1. For example, the following
# sequence of numbers will be generated for n = 22: 
#                                           end
#   22 11 34 17 52 26 13 40 20 10 5 16 8 4 2 1
# 
# It is conjectured (but not yet proven) that this algorithm will terminate at n = 1 for
# every integer n. Still, the conjecture holds for all integers up to at least 1,000,000.
# For an input n, the cycle-length of n is the number of numbers generated up to and
# including the 1. In the example above, the cycle length of 22 is 16. Given any two
# numbers i and j, you are to determine the maximum cycle length over all numbers
# between i and j, including both endpoints.
# 
#                                     Input
# The input will consist of a series of pairs of integers i and j, one pair of integers per
# line. All integers will be less than 1,000,000 and greater than 0.
# 
#                                                                     Output
# For each pair of input integers i and j, output i, j in the same order in which they
# appeared in the input and then the maximum cycle length for integers between and
# including i and j. These three numbers should be separated by one space, with all three
# numbers on one line and with one line of output for each line of input.
# 
# Sample Input
# 1 10
# 100 200
# 201 210
# 900 1000
# 
# Sample Output
# 1 10 20
# 100 200 125
# 201 210 89
# 900 1000 174

require 'benchmark'

class ThreeNPlusOne
  def initialize(low, high)
    @low, @high = low, high

    raise "invalid bounds: low is not in range: (low, high) = (#{low}, #{high})" unless (1..1000000).include? low
    raise "invalid bounds: high is not in range: (low, high) = (#{low}, #{high})" unless (1..1000000).include? high
    raise "invalid bounds: low is greater than high: (low, high) = (#{low}, #{high})" if low > high

    x = 1
    @length_hash = (1..19).inject({ 1 => 1 }) do |h, n|
      x *= 2

      h[x] = n + 1
      h
    end
  end

  def cycle_length(input)
    return @length_hash[input] if @length_hash.has_key?(input)

    next_num = input.even? ? (input / 2) : (3 * input + 1)

    @length_hash[input] = cycle_length(next_num) + 1
  end

  def self.max_cycle_length(low, high)
    test_obj = self.new(low, high)

    max_len = 1
    high.downto(low) do |x|
      len = test_obj.cycle_length(x)

      max_len = len if len > max_len
    end

    max_len
  end

  def self.max_cycle_length_prev(low, high)
    test_obj = self.new(low, high)

    max_len = 1

    low.upto(high) do |x|
      len = test_obj.cycle_length(x)

      max_len = len if len > max_len
    end

    max_len
  end

  def self.benchmark_cycle_length
    low, high = 1, 10000
    test_obj = self.new(low, high)

    puts
    puts "--- benchmark_cycle_length"

    n = 5000
    Benchmark.bm do |x|
      x.report do
        n.times { for m in low..high; test_obj.cycle_length(m); end }
      end
    end

    puts "---"
    puts

    true
  end

  def self.benchmark_max_cycle_length
    low, high = 1, 1000

    puts
    puts "--- benchmark_max_cycle_length"

    n = 5000
    Benchmark.bm do |x|
      x.report { n.times do; self.max_cycle_length(low, high); end }
    end

    puts "---"
    puts

    true
  end
end
