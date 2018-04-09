# coding: utf-8

EXAMPLE_SRT = <<SRT
1
00:00:33,433 --> 00:00:35,402
グエッ！
ウゥ～

2
00:00:35,402 --> 00:00:37,354
わたし　宇佐美いちか
SRT

RSpec.describe SubParser do
  it 'has a version number' do
    expect(SubParser::VERSION).not_to be nil
  end

  describe '#parse' do
    it 'should parse an empty string as empty array' do
      expect(SubParser.parse '').to be_empty
    end

    it 'should parse many subtitles' do
      subs = SubParser.parse EXAMPLE_SRT

      expect(subs.size).to eql 2
    end

    it 'should handle LFCR line endings' do
      raw = EXAMPLE_SRT.split("\n").join("\n\r")
      subs = SubParser.parse raw

      expect(subs.size).to eql 2
      expect(subs.first.text).to eql("グエッ！\nウゥ～")
    end
  end
end
