#!/usr/bin/env ruby
# this script parsing the URL from nhaccuatui then return the link list
# commandline will work list this: get_links.rb <URL> 
require 'nokogiri'
require 'open-uri'

if ARGV.length == 0 then
    puts "The command is: get_links.rb <http://example.com>"
    exit
end

this_url = ARGV[0]
page = Nokogiri::HTML(open(this_url))
puts page.title
scripts = page.css('script')
scripts.each do |s|
    puts s.text.lines
end
# searching the URL with key2

