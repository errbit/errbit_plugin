# frozen_string_literal: true

module ErrbitPlugin
  class NoneIssueTracker < IssueTracker
    def self.label; "none"; end
    def self.note
      "When no issue tracker has been configured, you will be able to " <<
      "leave comments on errors."
    end
    def self.fields; {}; end
    def self.icons
      @icons ||= {
        create: ["image/png", read_static_file("none_create.png")],
        goto: ["image/png", read_static_file("none_create.png")],
        inactive: ["image/png", read_static_file("none_inactive.png")],
      }
    end
    def self.read_static_file(file)
      File.read(File.expand_path(File.join(
        File.dirname(__FILE__), "..", "..", "..", "static", file)))
    end
    ##
    # The NoneIssueTracker is mark like configured? false because it not valid
    # like a real IssueTracker
    def configured?; false; end
    def errors; {}; end
    def url; ""; end
    def create_issue(*); false; end
    def close_issue(*); false; end
  end
end

ErrbitPlugin::Registry.add_issue_tracker(ErrbitPlugin::NoneIssueTracker)
