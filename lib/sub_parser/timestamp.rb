
module SubParser
  class Timestamp

    attr_reader :hours, :minutes, :seconds, :milliseconds

    def initialize hours = 0, minutes = 0, seconds = 0, milliseconds = 0
      @hours, @minutes, @seconds, @milliseconds = 0, 0, 0, 0

      self.milliseconds = milliseconds
      self.seconds += seconds
      self.minutes += minutes
      self.hours += hours
    end

    def to_s
      "%02d:%02d:%02d,%03d" % [hours, minutes, seconds, milliseconds]
    end

    def milliseconds= value
      @milliseconds = value % 1000
      self.seconds += value / 1000
    end

    def seconds= value
      @seconds = value % 60
      self.minutes += value / 60
    end

    def minutes= value
      @minutes = value % 60
      self.hours += value / 60
    end

    def hours= value
      @hours = value
    end

  end
end
