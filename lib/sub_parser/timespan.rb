
module SubParser
  class Timespan

    attr_reader :start_time, :end_time

    def initialize start_time, end_time
      @start_time, @end_time = start_time, end_time
    end

    def to_s
      '%s --> %s' % [start_time.to_s, end_time.to_s]
    end

    def self.parse raw
      if raw =~ /(.*) --> (.*)/
        Timespan.new Timestamp.parse($1), Timestamp.parse($2)
      end
    end

  end
end
