
def ts *args
  SubParser::Timestamp.new *args
end

RSpec.describe SubParser::Timestamp do

  subject { ts(1, 2, 3, 4) }

  describe "#to_s" do
    it "should print zeros if no values given" do
      expect(ts.to_s).to eq('00:00:00,000')
    end

    it "should print hours with at least two digits" do
      expect(ts(1).to_s).to eq('01:00:00,000')
    end

    it "should print minutes with two digits" do
      expect(ts(0, 2).to_s).to eq('00:02:00,000')
    end

    it "should print seconds with two digits" do
      expect(ts(0, 0, 3).to_s).to eq('00:00:03,000')
    end

    it "should print milliseconds with three digits" do
      expect(ts(0, 0, 0, 4).to_s).to eq('00:00:00,004')
    end
  end

  it "should have time unit readers" do
    expect(subject.hours).to eq(1)
    expect(subject.minutes).to eq(2)
    expect(subject.seconds).to eq(3)
    expect(subject.milliseconds).to eq(4)
  end

  it "should have time unit writers" do
    subject.hours = 5
    subject.minutes = 6
    subject.seconds = 7
    subject.milliseconds = 8

    expect(subject.to_s).to eq('05:06:07,008')
  end

  it "should increase seconds when adding to over 1000ms" do
    subject.milliseconds += 999
    expect(subject.to_s).to eq('01:02:04,003')
  end

  it "should increase minutes when adding to over 60s" do
    subject.seconds += 59
    expect(subject.to_s).to eq('01:03:02,004')
  end

  it "should increase hours when adding to over 60m" do
    subject.minutes += 59
    expect(subject.to_s).to eq('02:01:03,004')
  end

  it "should propagate overflow from milliseconds to hours" do
    subject.milliseconds += 60 * 60 * 1000
    expect(subject.to_s).to eq('02:02:03,004')
  end

  it "should propagate overflow on initialization" do
    ms = 60 * 60 * 1000 + 2 * 60 * 1000 + 3000 + 4
    expect(ts(0, 0, 0, ms).to_s).to eq('01:02:03,004')
  end

end
