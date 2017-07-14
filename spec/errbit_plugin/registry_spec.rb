describe ErrbitPlugin::Registry do
  describe '.add_issue_tracker' do
    before { described_class.clear_issue_trackers }

    let(:tracker) do
      Class.new(ErrbitPlugin::IssueTracker) do
        def self.label
          'something'
        end
      end
    end

    context 'with valid issue tracker' do
      before do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: true, message: ''))
      end

      it 'can be added' do
        described_class.add_issue_tracker(tracker)
        expect(described_class.issue_trackers).to eq({
          'something' => tracker
        })
      end

      it 'cannot be added twice' do
        described_class.add_issue_tracker(tracker)
        expect {
          described_class.add_issue_tracker(tracker)
        }.to raise_error(ErrbitPlugin::AlreadyRegisteredError)
      end
    end

    context 'with invalid issue tracker' do
      it 'raises an IncompatibilityError' do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: false, message: 'foo', errors: []))
        expect {
          described_class.add_issue_tracker(tracker)
        }.to raise_error(ErrbitPlugin::IncompatibilityError)
      end

      it 'puts the errors in the exception message' do
        allow(ErrbitPlugin::ValidateIssueTracker)
          .to receive(:new)
          .with(tracker)
          .and_return(double(valid?: false, message: 'foo', errors: %w(one two)))

        begin
          described_class.add_issue_tracker(tracker)
        rescue ErrbitPlugin::IncompatibilityError => e
          expect(e.message).to eq('one; two')
        end
      end
    end
  end

  describe '.add_notifier' do
    before { described_class.clear_notifiers }

    let(:notifier) do
      Class.new(ErrbitPlugin::Notifier) do
        def self.label
          'something'
        end
      end
    end

    context 'with a valid notifier class' do
      before do
        allow(ErrbitPlugin::ValidateNotifier)
          .to receive(:new)
          .with(notifier)
          .and_return(double(valid?: true, message: ''))
      end

      it 'adds the notifier plugin' do
        described_class.add_notifier(notifier)
        expect(described_class.notifiers).to eq({ 'something' => notifier })
      end

      it 'does not add the same plugin twice' do
        described_class.add_notifier(notifier)
        expect {
          described_class.add_notifier(notifier)
        }.to raise_error(ErrbitPlugin::AlreadyRegisteredError)
      end
    end

    context 'with an invalid notifier class' do
      it 'raise an IncompatibilityError' do
        allow(ErrbitPlugin::ValidateNotifier)
          .to receive(:new)
          .with(notifier)
          .and_return(double(valid?: false, message: 'foo', errors: []))
        expect {
          described_class.add_notifier(notifier)
        }.to raise_error(ErrbitPlugin::IncompatibilityError)
      end

      it 'puts the errors in the exception message' do
        allow(ErrbitPlugin::ValidateNotifier)
          .to receive(:new)
          .with(notifier)
          .and_return(double(valid?: false, message: 'foo', errors: %w(one two)))

        begin
          described_class.add_notifier(notifier)
        rescue ErrbitPlugin::IncompatibilityError => e
          expect(e.message).to eq('one; two')
        end
      end
    end
  end
end
