
RSpec.describe SubParser::Timespan do

  subject { SubParser::Timespan.new start_time, end_time }
  let(:start_time) { SubParser::Timestamp.new 0, 0, 0, 0 }
  let(:end_time)   { SubParser::Timestamp.new 0, 0, 1, 0 }

  it 'should require a start and end time' do
    expect { SubParser::Timespan.new }.to raise_error ArgumentError
    expect(subject.start_time).to equal(start_time)
    expect(subject.end_time).to equal(end_time)
  end

  describe '#to_s' do
    it 'should format to srt' do
      expect(subject.to_s).to eq('00:00:00,000 --> 00:00:01,000')
    end
  end

  describe '#parse' do
    it 'should parse a simple timespan' do
      text = '00:00:00,000 --> 00:00:01,000'
      span = SubParser::Timespan.parse text

      expect(span.start_time).to eql(start_time)
      expect(span.end_time).to eql(end_time)
    end
  end

end
