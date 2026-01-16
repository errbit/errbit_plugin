# frozen_string_literal: true

module ErrbitPlugin
  class IncompatibilityError < StandardError; end

  class AlreadyRegisteredError < StandardError; end

  module Registry
    @issue_trackers = {}

    def self.add_issue_tracker(klass)
      key = klass.label

      if issue_trackers.key?(key)
        raise AlreadyRegisteredError,
          "issue_tracker '#{key}' already registered"
      end

      validator = IssueTrackerValidator.new(klass)

      if validator.valid?
        @issue_trackers[key] = klass
      else
        raise IncompatibilityError.new(validator.errors.join("; "))
      end
    end

    def self.clear_issue_trackers
      @issue_trackers = {}
    end

    def self.issue_trackers
      @issue_trackers
    end
  end
end
