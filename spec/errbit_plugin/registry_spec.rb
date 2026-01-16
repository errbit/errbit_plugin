# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::Registry do
  before do
    described_class.clear_issue_trackers
  end

  let(:tracker) do
    tracker = Class.new(ErrbitPlugin::IssueTracker) do
      def self.label
        "something"
      end
    end
    tracker
  end

  describe ".add_issue_tracker" do
    context "with issue_tracker class valid" do
      before do
        allow(ErrbitPlugin::IssueTrackerValidator)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: true, message: ""))
      end

      it "add new issue_tracker plugin" do
        described_class.add_issue_tracker(tracker)

        expect(described_class.issue_trackers).to eq({
          "something" => tracker
        })
      end

      context "with already issue_tracker with this key" do
        it "raise ErrbitPlugin::AlreadyRegisteredError" do
          described_class.add_issue_tracker(tracker)

          expect do
            described_class.add_issue_tracker(tracker)
          end.to raise_error(ErrbitPlugin::AlreadyRegisteredError)
        end
      end
    end

    context "with an IssueTracker not valid" do
      it "raise an IncompatibilityError" do
        allow(ErrbitPlugin::IssueTrackerValidator)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: false, message: "foo", errors: []))

        expect do
          described_class.add_issue_tracker(tracker)
        end.to raise_error(ErrbitPlugin::IncompatibilityError)
      end

      it "puts the errors in the exception message" do
        allow(ErrbitPlugin::IssueTrackerValidator)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: false, message: "foo", errors: ["one", "two"]))

        begin
          described_class.add_issue_tracker(tracker)
        rescue ErrbitPlugin::IncompatibilityError => e
          expect(e.message).to eq("one; two")
        end
      end
    end
  end
end
