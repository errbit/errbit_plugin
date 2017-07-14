describe ErrbitPlugin::Notifier do
  describe '#initialize' do
    it 'stores options' do
      opts = { one: 'two' }
      obj = described_class.new(opts)
      expect(obj.options).to eq(opts)
    end
  end
end
