module ErrbitPlugin
  class IncompatibilityError < StandardError; end
  class AlreadyRegisteredError < StandardError; end

  module Registry
    @issue_trackers = {}
    @notifiers = {}

    def self.add_issue_tracker(klass)
      validate = ValidateIssueTracker.new(klass)

      unless validate.valid?
        raise IncompatibilityError.new(validate.errors.join('; '))
      end

      key = klass.label

      if issue_trackers.has_key?(key)
        raise AlreadyRegisteredError,
          "issue_tracker '#{key}' already registered"
      end

      @issue_trackers[key] = klass
    end

    def self.clear_issue_trackers
      @issue_trackers.clear
    end

    def self.issue_trackers
      @issue_trackers
    end

    def self.add_notifier(klass)
      validate = ValidateNotifier.new(klass)

      unless validate.valid?
        raise IncompatibilityError.new(validate.errors.join('; '))
      end

      key = klass.label

      if notifiers.has_key?(key)
        raise AlreadyRegisteredError,
          "notifier '#{key}' already registered"
      end

      @notifiers[key] = klass
    end

    def self.clear_notifiers
      @notifiers.clear
    end

    def self.notifiers
      @notifiers
    end
  end
end
