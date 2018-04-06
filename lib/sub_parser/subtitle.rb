
module SubParser
  class Subtitle

    extend Forwardable

    attr_reader :timespan, :text

    def_delegator :timespan, :start_time, :start_time
    def_delegator :timespan, :end_time, :end_time

    def initialize timespan, text
      @timespan, @text = timespan, text
    end

    def to_s
      "%s\n%s" % [timespan, text]
    end

  end
end
