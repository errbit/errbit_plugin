require 'spec_helper'

describe ErrbitPlugin::ValidateIssueTracker do
  describe "#valid?" do

    context "with a complete class" do
      class Foo < ErrbitPlugin::IssueTracker
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(Foo).valid?).to be true
      end
    end

    context "with class not inherit from ErrbitPlugin::IssueTracker" do

      class Bar
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(Bar).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(Bar)
        is.valid?
        expect(is.errors).to eql [[:not_inherited]]
      end
    end

    context "with no label method" do
      class Baz < ErrbitPlugin::IssueTracker
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(Baz).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(Baz)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :label]]
      end
    end

    context "without fields method" do
      class BazFields < ErrbitPlugin::IssueTracker
        def self.label; 'foo'; end
        def note; 'foo'; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazFields).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(BazFields)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :fields]]
      end
    end

    context "without configured? method" do
      class BazConfigured < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazConfigured).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(BazConfigured)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :configured?]]
      end
    end

    context "without errors method" do
      class BazCheckParams < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazCheckParams).valid?).to be false
      end

      it 'say not implement errors' do
        is = ErrbitPlugin::ValidateIssueTracker.new(BazCheckParams)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :errors]]
      end
    end

    context "without create_issue method" do
      class BazCreateIssue < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def errors; true; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazCreateIssue).valid?).to be false
      end
      it 'say not implement url' do
        is = ErrbitPlugin::ValidateIssueTracker.new(BazCreateIssue)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :create_issue]]
      end
    end

    context "without url method" do
      class BazUrl < ErrbitPlugin::IssueTracker
        def label; 'foo'; end
        def note; 'foo'; end
        def fields; ['foo']; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazUrl).valid?).to be false
      end

      it 'say not implement url' do
        is = ErrbitPlugin::ValidateIssueTracker.new(BazUrl)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :url]]
      end
    end

    context "without note method" do
      class BazNote < ErrbitPlugin::IssueTracker
        def self.label; 'foo'; end
        def self.fields; ['foo']; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'foo'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(BazNote).valid?).to be false
      end

      it 'say not implement note method' do
        is = ErrbitPlugin::ValidateIssueTracker.new(BazNote)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :note]]
      end
    end
  end
end
