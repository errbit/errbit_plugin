module ErrbitPlugin
  class NoneIssueTracker < IssueTracker
    def label; 'none'; end
    def note; 'When no issue tracker has been configured, you will be able to leave comments on errors.'; end
    def fields; []; end
    ##
    # The NoneIssueTracker is mark like configured? false because it not valid
    # like a real IssueTracker
    def configured?; false; end
    def check_params; true; end
    def create_issue; true; end
    def url; ''; end
    def comments_allowed?; true; end
  end
end

ErrbitPlugin::Register.add_issue_tracker(
  'IssueTracker::None',
  ErrbitPlugin::NoneIssueTracker
)
