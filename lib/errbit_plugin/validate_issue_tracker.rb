module ErrbitPlugin
  class ValidateIssueTracker
    def initialize(klass)
      @klass = klass
      @errors = []
    end
    attr_reader :errors

    def valid?
      good_inherit? &&
        implements_instance_methods? &&
        implements_class_methods?
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

    def implements_instance_methods?
      [:configured?, :errors, :create_issue, :url].all? do |method|
        if instance.respond_to?(method)
          true
        else
          add_errors(:instance_method_missing, method)
          false
        end
      end
    end

    def implements_class_methods?
      [:label, :fields, :note, :icons].all? do |method|
        if @klass.respond_to?(method)
          true
        else
          add_errors(:class_method_missing, method)
          false
        end
      end
    end

    def instance
      @instance ||= @klass.new({})
    end

    def add_errors(key, value=nil)
      @errors << [key, value].compact
    end
  end
end
