# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::Registry do
  before { ErrbitPlugin::Registry.clear_issue_trackers }

  let(:tracker) do
    Class.new(ErrbitPlugin::IssueTracker) do
      def self.label
        "something"
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
      let(:issue_tracker_validator) do
        instance_double(ErrbitPlugin::IssueTrackerValidator,
          valid?: false,
          errors: [])
      end

      it "raise an IncompatibilityError" do
        expect(ErrbitPlugin::IssueTrackerValidator)
          .to receive(:new)
          .with(tracker)
          .and_return(issue_tracker_validator)

        expect do
          ErrbitPlugin::Registry.add_issue_tracker(tracker)
        end.to raise_error(ErrbitPlugin::IncompatibilityError)
      end

      it "puts the errors in the exception message" do
        expect(ErrbitPlugin::IssueTrackerValidator)
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

  # before do
  #   ErrbitPlugin::Registry.clear_issue_trackers
  # end
  #
  # let(:tracker) {
  #   tracker = Class.new(ErrbitPlugin::IssueTracker) do
  #     def self.label
  #       "something"
  #     end
  #   end
  #   tracker
  # }
  #
  # describe ".add_issue_tracker" do
  #   context "with an IssueTracker not valid" do
  #     it "raise an IncompatibilityError" do
  #       allow(ErrbitPlugin::ValidateIssueTracker)
  #         .to receive(:new)
  #         .with(tracker)
  #         .and_return(double(valid?: false, message: "foo", errors: []))
  #       expect {
  #         ErrbitPlugin::Registry.add_issue_tracker(tracker)
  #       }.to raise_error(ErrbitPlugin::IncompatibilityError)
  #     end
  #
  #     it "puts the errors in the exception message" do
  #       allow(ErrbitPlugin::ValidateIssueTracker)
  #         .to receive(:new)
  #         .with(tracker)
  #         .and_return(double(valid?: false, message: "foo", errors: ["one", "two"]))
  #
  #       begin
  #         ErrbitPlugin::Registry.add_issue_tracker(tracker)
  #       rescue ErrbitPlugin::IncompatibilityError => e
  #         expect(e.message).to eq("one; two")
  #       end
  #     end
  #   end
  # end
end
