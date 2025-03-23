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

  it { expect(described_class.label).to eq("none") }

  it { expect(described_class.note).to eq("When no issue tracker has been configured, you will be able to leave comments on errors.") }

  it { expect(described_class.fields).to eq({}) }

  it do
    expect(described_class.icons).to eq({
      create: "errbit_plugin/none_create.png",
      goto: "errbit_plugin/none_create.png",
      inactive: "errbit_plugin/none_inactive.png"
    })
  end
end
