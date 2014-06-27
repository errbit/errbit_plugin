require 'spec_helper'

describe ErrbitPlugin::Register do
  before do
    ErrbitPlugin::Register.clear
  end

  describe ".add_issue_tracker" do
    context "with issue_tracker class valid" do
      before do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(ErrbitPlugin::IssueTracker)
          .and_return(double(:valid? => true, :message => ''))
      end
      it 'add new issue_tracker plugin' do
        ErrbitPlugin::Register.add_issue_tracker('foo', ErrbitPlugin::IssueTracker)
        expect(ErrbitPlugin::Register.issue_trackers).to eq({
          'foo' => ErrbitPlugin::IssueTracker
        })
      end
      context "with already issue_tracker with this key" do
        it 'raise ErrbitPlugin::IncompatibilityError' do
          ErrbitPlugin::Register.add_issue_tracker('foo', ErrbitPlugin::IssueTracker)
          expect {
            ErrbitPlugin::Register.add_issue_tracker('foo', ErrbitPlugin::IssueTracker)
          }.to raise_error(ErrbitPlugin::IncompatibilityError)
        end
      end
    end

    context "with an IssueTracker not valid" do
      it 'raise an IncompatibilityError' do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(ErrbitPlugin::IssueTracker)
          .and_return(double(:valid? => false, :message => 'foo', :errors => []))
        expect {
          ErrbitPlugin::Register.add_issue_tracker('foo', ErrbitPlugin::IssueTracker)
        }.to raise_error(ErrbitPlugin::IncompatibilityError)
      end

      it 'puts the errors in the exception message' do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(ErrbitPlugin::IssueTracker)
          .and_return(double(:valid? => false, :message => 'foo', :errors => ['one', 'two']))

        begin
          ErrbitPlugin::Register.add_issue_tracker('foo', ErrbitPlugin::IssueTracker)
        rescue ErrbitPlugin::IncompatibilityError => e
          expect(e.message).to eq('one; two')
        end
      end
    end
  end
end
