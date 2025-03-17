# frozen_string_literal: true

module ErrbitPlugin
  # Abstract class for issue trackers
  class IssueTracker
    attr_reader :options

    def initialize(options)
      @options = options
    end

    class << self
      def label
        raise NoMethodError, "The ErrbitPlugin::IssueTracker.label method is abstract, an implementation of it must be provided in the subclass"
      end

      def note
        raise NoMethodError, "The ErrbitPlugin::IssueTracker.note method is abstract, an implementation of it must be provided in the subclass"
      end

      def fields
        raise NoMethodError, "The ErrbitPlugin::IssueTracker.fields method is abstract, an implementation of it must be provided in the subclass"
      end

      def icons
        raise NoMethodError, "The ErrbitPlugin::IssueTracker.icons method is abstract, an implementation of it must be provided in the subclass"
      end
    end

    def configured?
      raise NoMethodError, "The ErrbitPlugin::IssueTracker#configured? method is abstract, an implementation of it must be provided in the subclass"
    end

    def errors
      raise NoMethodError, "The ErrbitPlugin::IssueTracker#errors method is abstract, an implementation of it must be provided in the subclass"
    end

    def create_issue
      raise NoMethodError, "The ErrbitPlugin::IssueTracker#create_issue method is abstract, an implementation of it must be provided in the subclass"
    end

    def close_issue
      raise NoMethodError, "The ErrbitPlugin::IssueTracker#close_issue method is abstract, an implementation of it must be provided in the subclass"
    end

    def url
      raise NoMethodError, "The ErrbitPlugin::IssueTracker#url method is abstract, an implementation of it must be provided in the subclass"
    end
  end
end
