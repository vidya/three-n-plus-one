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
