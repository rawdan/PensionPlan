require 'spec_helper'
require_relative '../bin/log_parser'

RSpec.describe LogParser do
  let(:parser) { LogParser.new }

  it 'can instantiate a new parser' do
    expect(parser).not_to be nil
  end

  it 'returns false when no log is passed' do
    expect(parser.parse).to eq false
  end
end