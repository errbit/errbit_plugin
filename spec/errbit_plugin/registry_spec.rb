# frozen_string_literal: true

require "spec_helper"

describe ErrbitPlugin::Registry do
  before do
    ErrbitPlugin::Registry.clear_issue_trackers
  end

  let(:tracker) {
    tracker = Class.new(ErrbitPlugin::IssueTracker) do
      def self.label
        "something"
      end
    end
    tracker
  }

  describe ".add_issue_tracker" do
    context "with issue_tracker class valid" do
      before do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: true, message: ""))
      end
      it "add new issue_tracker plugin" do
        ErrbitPlugin::Registry.add_issue_tracker(tracker)
        expect(ErrbitPlugin::Registry.issue_trackers).to eq({
          "something" => tracker
        })
      end
      context "with already issue_tracker with this key" do
        it "raise ErrbitPlugin::AlreadyRegisteredError" do
          ErrbitPlugin::Registry.add_issue_tracker(tracker)
          expect {
            ErrbitPlugin::Registry.add_issue_tracker(tracker)
          }.to raise_error(ErrbitPlugin::AlreadyRegisteredError)
        end
      end
    end

    context "with an IssueTracker not valid" do
      it "raise an IncompatibilityError" do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: false, message: "foo", errors: []))
        expect {
          ErrbitPlugin::Registry.add_issue_tracker(tracker)
        }.to raise_error(ErrbitPlugin::IncompatibilityError)
      end

      it "puts the errors in the exception message" do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: false, message: "foo", errors: ["one", "two"]))

        begin
          ErrbitPlugin::Registry.add_issue_tracker(tracker)
        rescue ErrbitPlugin::IncompatibilityError => e
          expect(e.message).to eq("one; two")
        end
      end
    end
  end
end
