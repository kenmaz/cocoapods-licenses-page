#! /usr/bin/env ruby

podfile = "Podfile"
unless File.exist? podfile
  puts "no Podfile"
  exit
end

File.open(podfile) do |file|
  puts file
end


