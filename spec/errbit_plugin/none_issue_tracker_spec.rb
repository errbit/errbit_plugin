# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::NoneIssueTracker do
  let(:options) { {} }

  subject { described_class.new(options) }

  it { expect(subject).to be_an(ErrbitPlugin::IssueTracker) }
end
