
require "sub_parser/version"
require "sub_parser/subtitle"
require "sub_parser/timespan"
require "sub_parser/timestamp"

module SubParser

  def self.parse subtitles
    subtitles
      .gsub(/\r/, '')
      .split(/\n\n/)
      .map { |raw| Subtitle.parse raw }
  end

end
