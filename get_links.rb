#!/usr/bin/env ruby
# this script parsing the URL from nhaccuatui then return the link list
# commandline will work list this: get_links.rb <URL> 
require 'nokogiri'
require 'open-uri'
require 'uri'

def extract_everything(url, extracting_pattern)
    page = open(url)
    links = Array.new
    page.each_line do |line|
        if extracting_pattern.match(line) then
            links << extracting_pattern.match(line).to_s
        end
    end
    return links
end

def write2file(contents, filename)
    File.open(filename, "w+") do |fhandler|
        contents.each do |line|
            fhandler.puts (line)
        end
    end
end

if ARGV.length == 0 then
    puts "The command is: get_links.rb <http://www.nhaccuatui.com/>"
    exit
end
# main program
this_url = ARGV[0]
playlist_pattern = /http:\/\/www.nhaccuatui.com\/flash\/xml\?key[12]=[\dabcdef]+/
link_pattern = /http:\/\/[\w\.\/\-\_]+\.mp3/
filename = File.basename(URI.parse(this_url).path, ".html")

playlist_link = extract_everything this_url, playlist_pattern
links = extract_everything playlist_link[0], link_pattern
write2file links, filename

# in case download
if ARGV[1] == "download" then
    download_dir = File.basename filename, ".*"
    Dir.mkdir download_dir
    Dir.chdir(download_dir) do 
        
    end
end

