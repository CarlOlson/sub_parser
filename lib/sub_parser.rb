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

  def self.join subtitles
    subtitles
      .each_with_index
      .map { |s, i| "#{i+1}\n#{s}" }
      .join("\n\n")
  end
end
