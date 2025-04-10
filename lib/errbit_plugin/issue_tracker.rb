# frozen_string_literal: true

module ErrbitPlugin
  # abstract class for issue trackers
  class IssueTracker
    attr_reader :options

    def initialize(options)
      @options = options
    end
  end
end
