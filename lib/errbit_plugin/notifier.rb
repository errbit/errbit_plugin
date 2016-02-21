module ErrbitPlugin
  # abstract class for issue trackers
  class Notifier
    attr_reader :options

    def initialize(options)
      @options = options
    end
  end
end
