require 'spec_helper'

describe ErrbitPlugin::ValidateIssueTracker do
  describe "#valid?" do

    context "with a complete class" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be true
      end
    end

    context "with class not inherit from ErrbitPlugin::IssueTracker" do
      klass = Class.new do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def initialize(params); end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'says :not_inherited' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:not_inherited]]
      end
    end

    context "with no label method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :label]]
      end
    end

    context "with no icons method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.label; 'alabel'; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :icons]]
      end
    end

    context "without fields method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.icons; {}; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :fields]]
      end
    end

    context "without configured? method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement configured?' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :configured?]]
      end
    end

    context "without errors method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def configured?; true; end
        def create_issue; 'http'; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement errors' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :errors]]
      end
    end

    context "without create_issue method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def configured?; true; end
        def errors; true; end
        def url; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end
      it 'say not implement url' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :create_issue]]
      end
    end

    context "without url method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.note; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement url' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:instance_method_missing, :url]]
      end
    end

    context "without note method" do
      klass = Class.new(ErrbitPlugin::IssueTracker) do
        def self.label; 'foo'; end
        def self.fields; ['foo']; end
        def self.icons; {}; end
        def configured?; true; end
        def errors; true; end
        def create_issue; 'http'; end
        def url; 'foo'; end
      end

      it 'not valid' do
        expect(ErrbitPlugin::ValidateIssueTracker.new(klass).valid?).to be false
      end

      it 'say not implement note method' do
        is = ErrbitPlugin::ValidateIssueTracker.new(klass)
        is.valid?
        expect(is.errors).to eql [[:class_method_missing, :note]]
      end
    end
  end
end
