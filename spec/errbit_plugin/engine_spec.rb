# frozen_string_literal: true

require "spec_helper"

RSpec.describe ErrbitPlugin::Engine do
  it { expect(described_class.ancestors).to include(Rails::Engine) }
end
