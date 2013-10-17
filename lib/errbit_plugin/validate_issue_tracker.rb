require 'abstract_type'

module ErrbitPlugin
  class ValidateIssueTracker
    def initialize(klass)
      @klass = klass
    end

    def valid?
      good_inherit? &&
        implement_method?
    end

    def message
      ''
    end

    private

    def good_inherit?
      @klass.ancestors.include?(ErrbitPlugin::IssueTracker)
    end

    def implement_method?
      begin
        [:label, :fields, :configured?, :check_params, :create_issue, :url].each do |method|
          instance.send(method)
        end
        true
      rescue NotImplementedError
        false
      end
    end

      def instance
        @instance ||= @klass.new
      end

  end
end
