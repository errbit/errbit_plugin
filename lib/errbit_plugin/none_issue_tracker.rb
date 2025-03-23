# frozen_string_literal: true

module ErrbitPlugin
  class NoneIssueTracker < IssueTracker
    def self.label
      "none"
    end

    def self.note
      "When no issue tracker has been configured, you will be able to leave comments on errors."
    end

    def self.fields
      {}
    end

    def self.icons
      {
        create: "errbit_plugin/none_create.png",
        goto: "errbit_plugin/none_create.png",
        inactive: "errbit_plugin/none_inactive.png"
      }
    end

    ##
    # The NoneIssueTracker is mark like configured? false because it not valid
    # like a real IssueTracker
    def configured?
      false
    end

    def errors
      {}
    end

    def url
      ""
    end

    def create_issue(*)
      false
    end

    def close_issue(*)
      false
    end
  end
end

ErrbitPlugin::Registry.add_issue_tracker(ErrbitPlugin::NoneIssueTracker)
