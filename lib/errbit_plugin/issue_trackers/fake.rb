module ErrbitPlugin
  class FakeIssueTracker < IssueTracker
    def self.label
      'fake'
    end

    def self.note
      'A fake issue tracker to help in testing purpose'
    end

    def self.fields
      {
        :foo => {:label => 'foo'},
        :bar => {:label => 'bar'}
      }
    end

    def configured?
      !errors.any?
    end

    def errors
      errors = {}
      errors[:foo] = 'foo is required' unless params[:foo]
      errors[:bar] = 'bar is required' unless params[:bar]

      errors
    end

    def create_issue(problem, reported_by=nil); true; end

    def url; ''; end
  end
end

ErrbitPlugin::Registry.add_issue_tracker(ErrbitPlugin::FakeIssueTracker)
