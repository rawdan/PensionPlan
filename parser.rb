#!/usr/bin/env ruby
require_relative 'bin/model'

file = File.open(ARGV.first)
results = Model.new file: file
puts 'Webpages ordered by page views descending:'
puts results.order_by_page_views
puts 'Webpages ordered by unique page views descending:'
puts results.order_by_unique_page_views

# command: ./parser.rb webserver.log
# or
# ruby parser.rb webserver.log