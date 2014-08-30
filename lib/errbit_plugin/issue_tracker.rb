module ErrbitPlugin
  class IssueTracker
    attr_reader :app, :params

    def initialize(app, params)
      @app = app
      @params = params
    end
  end
end
