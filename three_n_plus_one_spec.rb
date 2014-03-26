
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

require 'pry'
require_relative 'three_n_plus_one'

describe ThreeNPlusOne do
  it "should check if low of range is <= high of range" do
    expect { ThreeNPlusOne.new(10, 4) }.to raise_error
  end

  it "should check range low is in (1..1000000)" do
    expect { ThreeNPlusOne.new(0, 20) }.to raise_error(/low is not in range/)
  end

  it "should check range high is in (1..1000000)" do
    expect { ThreeNPlusOne.new(1, 2000000) }.to raise_error(/high is not in range/)
  end

  it "should check that low <= high" do
    expect { ThreeNPlusOne.new(40, 20) }.to raise_error(/low is greater than high/)
  end

  describe "#cycle_length" do
    before :each do
      @test_obj = ThreeNPlusOne.new(1, 16)
    end

    it "should return 1 for input 1" do
      @test_obj.cycle_length(1).should eq(1)
    end

    it "should return 3 for input 4" do
      @test_obj.cycle_length(4).should eq(3)
    end

    it "should return 6 for input 5" do
      @test_obj.cycle_length(5).should eq(6)
    end

    it "should return 8 for input 3" do
      @test_obj.cycle_length(3).should eq(8)
    end

  end

  describe "self#max_cycle_length" do
    it "should return 20 for (low, high) = (1, 10)" do
      ThreeNPlusOne.max_cycle_length(1, 10).should eq(20)
    end

    it "should return 125 for (low, high) = (1001, 200)" do
      ThreeNPlusOne.max_cycle_length(100, 200).should eq(125)
    end

    it "should return 89 for (low, high) = (201, 210)" do
      ThreeNPlusOne.max_cycle_length(201, 210).should eq(89)
    end

    it "should return 174 for (low, high) = (900, 1000)" do
      ThreeNPlusOne.max_cycle_length(900, 1000).should eq(174)
    end
  end

  describe "self#benchmark_cycle_length" do
    it "should return true" do
      ThreeNPlusOne.benchmark_cycle_length.should eq(true)
    end
  end

  describe "self#benchmark_max_cycle_length" do
    it "should return true" do
      ThreeNPlusOne.benchmark_max_cycle_length.should eq(true)
    end
  end

end