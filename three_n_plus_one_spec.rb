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