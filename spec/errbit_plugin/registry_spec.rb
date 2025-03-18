# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::Registry do
  before { ErrbitPlugin::Registry.clear_issue_trackers }

  let(:tracker) do
    Class.new(ErrbitPlugin::IssueTracker) do
      def self.label
        "something"
      end

      def self.note
        "note"
      end

      def self.fields
        ["foo"]
      end

      def self.icons
        {}
      end

      def configured?
        true
      end

      def errors
        true
      end

      def create_issue
        "http"
      end

      def close_issue
        "http"
      end

      def url
        "http"
      end
    end
  end

  describe ".add_issue_tracker" do
    context "when issue tracker is valid" do
      context "when issue tracker is not registered" do
        let(:issue_tracker_validator) do
          instance_double(ErrbitPlugin::IssueTrackerValidator,
            valid?: true,
            errors: [])
        end

        before do
          expect(ErrbitPlugin::IssueTrackerValidator)
            .to receive(:new)
            .with(tracker)
            .and_return(issue_tracker_validator)
        end

        it "add new issue_tracker plugin" do
          ErrbitPlugin::Registry.add_issue_tracker(tracker)

          expect(ErrbitPlugin::Registry.issue_trackers).to eq({"something" => tracker})
        end
      end

      context "when issue tracker is already registered" do
        let(:issue_tracker_validator) do
          instance_double(ErrbitPlugin::IssueTrackerValidator,
            valid?: true,
            errors: [])
        end

        before { ErrbitPlugin::Registry.add_issue_tracker(tracker) }

        it "raise ErrbitPlugin::AlreadyRegisteredError" do
          expect do
            ErrbitPlugin::Registry.add_issue_tracker(tracker)
          end.to raise_error(ErrbitPlugin::AlreadyRegisteredError)
        end
      end
    end

    context "when issue tracker is not valid" do
      context "raise IncompatibilityError" do
        let(:issue_tracker_validator) do
          instance_double(ErrbitPlugin::IssueTrackerValidator,
            valid?: false,
            errors: [])
        end

        before do
          expect(ErrbitPlugin::IssueTrackerValidator)
            .to receive(:new)
            .with(tracker)
            .and_return(issue_tracker_validator)
        end

        it "raise an IncompatibilityError" do
          expect do
            ErrbitPlugin::Registry.add_issue_tracker(tracker)
          end.to raise_error(ErrbitPlugin::IncompatibilityError)
        end
      end

      context "show errors in the exception message" do
        let(:issue_tracker_validator) do
          instance_double(ErrbitPlugin::IssueTrackerValidator,
            valid?: false,
            errors: ["one", "two"])
        end

        before do
          expect(ErrbitPlugin::IssueTrackerValidator)
            .to receive(:new)
            .with(tracker)
            .and_return(issue_tracker_validator)
        end

        it "puts the errors in the exception message" do
          ErrbitPlugin::Registry.add_issue_tracker(tracker)
        rescue ErrbitPlugin::IncompatibilityError => e
          expect(e.message).to eq("one; two")
        end
      end
    end
  end
end
