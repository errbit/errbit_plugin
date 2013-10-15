module ErrbitPlugin
  class IncompatibilityError < Exception; end
  module Register
    def self.add_issue_tracker(key, klass)
      @issue_trackers ||= {}
      raise IncompatibilityError.new('issue_tracker already register') if @issue_trackers.key?(key)
      @issue_trackers[key] = klass
    end

    def self.issue_trackers
      @issue_trackers
    end

    def self.clear
      @issue_trackers = {}
    end
  end
end
