require 'spec_helper'

describe ErrbitPlugin::Register do
  before do
    ErrbitPlugin::Register.clear
  end

  describe ".add_issue_tracker" do

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
end
