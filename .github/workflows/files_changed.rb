# Copyright (c) 2021 Oracle and/or its affiliates.

require 'json'
require 'net/http'
require 'csv'

pull_url = ''

if ARGV.length > 0
  pull_url = ARGV[0]
end

if ENV.include?('INPUT_PULL_URL') && ENV['INPUT_PULL_URL'].to_s.length > 0
  pull_url = ENV['INPUT_PULL_URL']
end

ret = JSON.parse('[]')
looping = true
page = 1

while (looping) do
  j_url = "#{pull_url}/files?per_page=100&page=#{page}"
  j_resp = Net::HTTP.get_response(URI(j_url), { 'Accept' => 'application/vnd.github.v3+json'})
  resp = JSON.parse('[]')
  
  if j_resp.code == '200'
    resp = JSON.parse(j_resp.body)
  else
    looping = false
  end
  
  if resp.count > 0
    ret += resp
  else
    looping = false
  end
  
  page += 1
end

all_files_changed = []
added_files = []
copied_files = []
deleted_files = []
modified_files = []
renamed_files = []

if ret.count > 0
  ret.each do |entry|
    fname = entry['filename']
    all_files_changed << fname
    case entry['status']
    when 'added'
      added_files << fname
    when 'copied'
      copied_files << fname
    when 'deleted'
      deleted_files << fname
    when 'modified'
      modified_files << fname
    when 'renamed'
      renamed_files << fname
    end
  end
end

puts "all_files_changed: #{all_files_changed.to_s}"
puts "::set-output name=all_files_changed::#{all_files_changed.to_s}"

puts "added_files: #{added_files.to_s}"
puts "::set-output name=added_files::#{added_files.to_s}"

puts "copied_files: #{copied_files.to_s}"
puts "::set-output name=copied_files::#{copied_files.to_s}"

puts "deleted_files: #{deleted_files.to_s}"
puts "::set-output name=deleted_files::#{deleted_files.to_s}"

puts "modified_files: #{modified_files.to_s}"
puts "::set-output name=modified_files::#{modified_files.to_s}"

puts "renamed_files: #{renamed_files.to_s}"
puts "::set-output name=renamed_files::#{renamed_files.to_s}"