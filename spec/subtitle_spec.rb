RSpec.describe SubParser::Subtitle do

  subject { SubParser::Subtitle.new timespan, text }
  let(:timespan)   { SubParser::Timespan.new start_time, end_time }
  let(:start_time) { SubParser::Timestamp.new 0, 0, 0, 0 }
  let(:end_time)   { SubParser::Timestamp.new 0, 0, 1, 0 }
  let(:text)       { 'example text' }

  it 'should require a time span and text' do
    expect { SubParser::Subtitle.new }.to raise_error ArgumentError
    expect { SubParser::Subtitle.new nil }.to raise_error ArgumentError
  end

  it 'should have attribute readers' do
    expect(subject.timespan).to equal(timespan)
    expect(subject.start_time).to equal(start_time)
    expect(subject.end_time).to equal(end_time)
    expect(subject.text).to equal(text)
  end

  describe '#to_s' do
    it 'should format to srt' do
      expect(subject.to_s).to eq("00:00:00,000 --> 00:00:01,000\nexample text")
    end
  end

  describe '#parse' do
    it 'should parse a subtitle' do
      raw = ['1', '00:00:00,000 --> 00:00:00,000', '']
      subs = SubParser::Subtitle.parse raw.join("\n")

      expect(subs.text).to eql ''
      expect(subs.timespan.to_s).to eql raw[1]
    end

    it 'should parse multi-line subtitles' do
      raw = ['1', '00:00:00,000 --> 00:00:00,000', 'Hello,', 'World!']
      subs = SubParser::Subtitle.parse raw.join("\n")

      expect(subs.text).to eql("Hello,\nWorld!")
    end
  end

end
