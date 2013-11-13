module ErrbitPlugin
  class FakeIssueTracker < IssueTracker
    def label; 'fake'; end
    def note; 'A fake issue tracker to help in testing purpose'; end
    def fields
      {
        :foo => 'bar'
      }
    end
    ##
    # The NoneIssueTracker is mark like configured? false because it not valid
    # like a real IssueTracker
    def configured?; true; end
    def check_params; true; end
    def create_issue; true; end
    def url; ''; end
    def comments_allowed?; false; end
  end
end

ErrbitPlugin::Register.add_issue_tracker(
  'fake',
  ErrbitPlugin::FakeIssueTracker
)
