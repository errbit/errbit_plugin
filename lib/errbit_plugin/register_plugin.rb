module ErrbitPlugin
  class IncompatibilityError < Exception; end

  module Register
    def self.add_issue_tracker(key, klass)
      @issue_trackers ||= {}
      raise IncompatibilityError.new('issue_tracker already register') if @issue_trackers.key?(key)
      validate = ValidateIssueTracker.new(klass)
      if validate.valid?
        @issue_trackers[key] = klass
      else
        raise IncompatibilityError.new(validate.message)
      end
    end

    def self.issue_trackers
      @issue_trackers
    end

    def self.issue_tracker(key)
      issue_trackers[key]
    end

    def self.clear
      @issue_trackers = {}
    end
  end
end
