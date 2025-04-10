# frozen_string_literal: true

module ErrbitPlugin
  class ValidateIssueTracker
    def initialize(klass)
      @klass = klass
      @errors = []
    end
    attr_reader :errors

    def valid?
      valid_inherit = good_inherit?
      valid_instance_methods = implements_instance_methods?
      valid_class_methods = implements_class_methods?

      valid_inherit && valid_instance_methods && valid_class_methods
    end

    private

    def good_inherit?
      if @klass.ancestors.include?(ErrbitPlugin::IssueTracker)
        true
      else
        add_errors(:not_inherited)
        false
      end
    end

    def implements_instance_methods?
      impl = [:configured?, :errors, :create_issue, :url].map do |method|
        if instance.respond_to?(method)
          true
        else
          add_errors(:instance_method_missing, method)
          false
        end
      end

      impl.all? { |value| value == true }
    end

    def implements_class_methods?
      impl = [:label, :fields, :note, :icons].map do |method|
        if @klass.respond_to?(method)
          true
        else
          add_errors(:class_method_missing, method)
          false
        end
      end

      impl.all? { |value| value == true }
    end

    def instance
      @instance ||= @klass.new({})
    end

    def add_errors(key, value = nil)
      @errors << [key, value].compact
    end
  end
end
