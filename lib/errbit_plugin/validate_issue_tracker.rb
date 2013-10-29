module ErrbitPlugin
  class ValidateIssueTracker
    def initialize(klass)
      @klass = klass
      @errors = []
    end
    attr_reader :errors

    def valid?
      good_inherit? &&
        implement_method?
    end

    def message
      ''
    end

    private

    def good_inherit?
      unless @klass.ancestors.include?(ErrbitPlugin::IssueTracker)
        add_errors(:not_inherited)
        false
      else
        true
      end
    end

    def implement_method?
      [:comments_allowed?, :label, :fields, :configured?, :check_params, :create_issue, :url].all? do |method|
        if instance.respond_to?(method)
          true
        else
          add_errors(:method_missing, method)
          false
        end
      end
    end

    def instance
      @instance ||= @klass.new(Object.new, {})
    end

    def add_errors(key, value=nil)
      @errors << [key, value].compact
    end

  end
end
