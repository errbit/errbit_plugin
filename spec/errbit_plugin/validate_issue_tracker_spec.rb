require 'spec_helper'

describe ErrbitPlugin::ValidateIssueTracker do
  describe "#valid?" do

    context "with a complete class" do
      class Foo < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def check_params; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(Foo).valid?).to be_true
      end
    end
    context "with class not inherit from ErrbitPlugin::IssueTracker" do
      class Bar
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def check_params; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(Bar).valid?).to be_false
      end
    end

    context "with no label method" do
      class Baz < ErrbitPlugin::IssueTracker
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def check_params; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(Baz).valid?).to be_false
      end
    end

    context "without fields method" do
      class BazFields < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def configured?; true; end
        def check_params; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazFields).valid?).to be_false
      end
    end

    context "without configured? method" do
      class BazConfigured < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def check_params; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazConfigured).valid?).to be_false
      end
    end

    context "without check_params method" do
      class BazCheckParams < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazCheckParams).valid?).to be_false
      end
    end

    context "without create_issue method" do
      class BazCreateIssue < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def check_params; true; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazCreateIssue).valid?).to be_false
      end
    end

    context "without url method" do
      class BazUrl < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def check_params; true; end
        def create_issue; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazUrl).valid?).to be_false
      end
    end
  end
end
