require_relative 'log_parser'
require 'set'

class Model
  attr_reader :log_parser, :file, :data

  def the_truth
    true
  end

  def initialize(log_parser: LogParser.new, file: false)
    @log_parser = LogParser.new
    @file = file
    get_data
  end

  def order_by_page_views
    data.keys
        .map { |webpage| {page: webpage, visits: data[webpage][:visits] } }
        .sort_by { |a| a[:visits] }
        .reverse
        .map { |page_visits| "#{page_visits[:page]} #{page_visits[:visits]} visits"}
        .join("\n")
  end

  def order_by_unique_page_views
    data.keys
        .map { |webpage| {page: webpage, visits: data[webpage][:visitors].size } }
        .sort_by { |a| a[:visits] }
        .reverse
        .map { |page_visits| "#{page_visits[:page]} #{page_visits[:visits]} visits"}
        .join("\n")
  end

  private

  def get_data
    @data = {}
    return data unless file
    file.each do |log_line|
      line_data = log_parser.parse log: log_line
      if data[line_data[:page]]
        @data[line_data[:page]][:visits] += 1
        @data[line_data[:page]][:visitors] << line_data[:user]
      else
        @data[line_data[:page]] = {
            visits: 1,
            visitors: Set.new([line_data[:user]])
        }
      end
    end
    @data
  end
end