# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::NoneIssueTracker do
  let(:options) { {} }

  subject { described_class.new(options) }

  it { expect(subject).to be_an(ErrbitPlugin::IssueTracker) }

  it { expect(subject.configured?).to eq(false) }

  it { expect(subject.errors).to eq({}) }

  it { expect(subject.url).to eq("") }

  it { expect(subject.create_issue).to eq(false) }

  it { expect(subject.close_issue).to eq(false) }
end
