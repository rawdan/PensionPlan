require 'spec_helper'
require 'tempfile'
require_relative '../bin/model'
require_relative '../bin/log_parser'

RSpec.describe Model do
  it 'should be true' do
    expect(true).to be true
  end

  it 'can initialize with the parser' do
    results = Model.new(log_parser: LogParser.new)
    expect(results.log_parser).to be_a LogParser
  end

  it 'can initialize with a file object' do
    results = Model.new file: File.open(File.join(Dir.pwd, 'webserver.log'), 'r')
    expect(results.file).to be_a File
  end

  it 'initializes the data after reading the file' do
    Tempfile.create('log') do |f|
      f.puts '/home 184.123.665.067'
      f.puts '/about/2 444.701.448.104'
      f.puts '/about/2 444.701.448.104'
      f.rewind
      expected_results = {
          "/about/2" => { visits: 2, visitors: Set.new(['444.701.448.104'])},
          "/home" => { visits: 1, visitors: Set.new(['184.123.665.067'])}
      }
      results = Model.new file: f
      expect(results.data).to eq expected_results
    end
  end

  it 'returns list of webpages with most page views ordered from most pages views to less page views' do
    Tempfile.create('log') do |f|
      f.puts '/home 184.123.665.067'
      f.puts '/about/2 444.701.448.104'
      f.puts '/about/2 444.701.448.104'
      f.rewind
      results = Model.new(file: f)
      expect(results.order_by_page_views()).to eq "/about/2 2 visits\n/home 1 visits"
    end
  end

  it 'returns list of webpages with most unique page views ordered from most pages views to less page views' do
    Tempfile.create('log') do |f|
      f.puts '/home 184.123.665.067'
      f.puts '/home 184.123.665.067'
      f.puts '/about/2 444.701.448.104'
      f.puts '/about/2 444.701.448.103'
      f.rewind
      results = Model.new(file: f)
      expect(results.order_by_unique_page_views).to eq "/about/2 2 visits\n/home 1 visits"
    end
  end
end