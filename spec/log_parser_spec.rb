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

  it 'returns false if anything else except a string is passed in' do
    expect(parser.parse(log: nil)).to eq false
  end

  it 'returns false with an empty log passed in' do
    expect(parser.parse(log: '')).to eq false
  end

  it 'parses correctly a log line' do
    line_to_parse = '/help_page/1 126.318.035.038'
    result = { page: '/help_page/1', user: '126.318.035.038' }
    expect(parser.parse(log: line_to_parse)).to eq result
  end
end