#! /usr/bin/env ruby

require 'rubygems'
require 'cocoapods-core'
require 'pp'

path = ARGV[0]
podfile = Pod::Podfile.from_file(path)

# [TODO] multi target
target_definition = podfile.root_target_definitions[0]

names = []
target_definition.non_inherited_dependencies.each do |dependency|
  names << dependency.name
end
names.sort!

podsdir = nil
podfile.defined_in_file.dirname.children.each do |entry|
  if entry.to_s.end_with? '/Pods'
    podsdir = entry
    break
  end
end

puts '<html><body>'
puts '<h1>LICENCES</h1>'

puts '<ul>'
names.each do |name|
  puts "<li><a href='##{name}'>#{name}</a></li>" 
end
puts '</ul>'

names.each do |name|
  license_found = false
  podsdir.children.each do |pods|
    if pods.to_s.end_with? name
      pods.children.each do |podbody|
        if podbody.to_s.include? 'LICENSE' 
          puts '<hr>'
          puts "<h2 id='#{name}'>#{name}</h2>" 
          puts '<p>'
          File::open(podbody) do |f|
            f.each do |line|
              puts line
            end
          end
          puts '</p>'
          license_found = true
        end 
      end
    end
  end
  unless license_found
      puts '<hr>'
      puts "<h2 id='#{name}'>#{name}</h2>" 
      puts 'LICENSE fle is not found'
  end  
end 

puts '</body></html>'
