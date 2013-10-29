module ErrbitPlugin
  class IssueTracker

    def initialize(app, params)
      @app = app
      @params = params
    end
    attr_reader :app, :params

    def add_error(key, msg)
      @errors ||= {}
      @errors[key] ||= []
      @errors[key] << msg
    end

  def issue_title(problem)
    "[#{ problem.environment }][#{ problem.where }] #{problem.message.to_s.truncate(100)}"
  end
  end
end
