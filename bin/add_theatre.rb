#!/usr/bin/env ruby

begin
  puts "opening #{ARGV[0]}"
  data = YAML.load_file ARGV[0]
  #theatre = Theatre.create

rescue
  puts "no file"
  exit
end

puts "creating theatre: #{data['name']}"
theatre = Theatre.create name: data['name'], width: data['width'], webname: data['webname']

data['segments'].each do |k,v|

  height = v.values.map{|s| s['y']}.max

  puts "creating segment: #{k}"
  segment = Segment.create name: k, theatre_id: theatre.id, height: height
  v.each do |seat,coords|
    puts "creating seat: #{seat}"

    seat = Seat.create name: seat, x: coords['x'], y: coords['y'], segment_id: segment.id, 
        percent_x: (100.0*coords['x'])/data['width'], percent_y: (100.0*coords['y'])/height
  end
end

