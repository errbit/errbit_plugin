require 'abstract_type'
module ErrbitPlugin
  class IssueTracker

    include AbstractType

    abstract_method :label
    abstract_method :note
    abstract_method :fields
    abstract_method :configured?
    abstract_method :check_params
    abstract_method :create_issue
    abstract_method :url
  end
end
