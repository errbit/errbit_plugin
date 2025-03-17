# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::IssueTracker do
  let(:options) { {} }

  subject { described_class.new(options) }

  describe "#options" do
    it { expect(subject.options).to eq({}) }
  end

  describe "#configured?" do
    let(:message) { "The ErrbitPlugin::IssueTracker#configured? method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { subject.configured? }.to raise_error(NoMethodError, message) }
  end

  describe "#errors" do
    let(:message) { "The ErrbitPlugin::IssueTracker#errors method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { subject.errors }.to raise_error(NoMethodError, message) }
  end

  describe "#create_issue" do
    let(:message) { "The ErrbitPlugin::IssueTracker#create_issue method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { subject.create_issue }.to raise_error(NoMethodError, message) }
  end

  describe "#close_issue" do
    let(:message) { "The ErrbitPlugin::IssueTracker#close_issue method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { subject.close_issue }.to raise_error(NoMethodError, message) }
  end

  describe "#url" do
    let(:message) { "The ErrbitPlugin::IssueTracker#url method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { subject.url }.to raise_error(NoMethodError, message) }
  end

  describe ".label" do
    let(:message) { "The ErrbitPlugin::IssueTracker.label method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { described_class.label }.to raise_error(NoMethodError, message) }
  end

  describe ".note" do
    let(:message) { "The ErrbitPlugin::IssueTracker.note method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { described_class.note }.to raise_error(NoMethodError, message) }
  end

  describe ".fields" do
    let(:message) { "The ErrbitPlugin::IssueTracker.fields method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { described_class.fields }.to raise_error(NoMethodError, message) }
  end

  describe ".icons" do
    let(:message) { "The ErrbitPlugin::IssueTracker.icons method is abstract, an implementation of it must be provided in the subclass" }

    it { expect { described_class.icons }.to raise_error(NoMethodError, message) }
  end
end
