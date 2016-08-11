#!/usr/bin/ruby
VERSION = '0.1'

require 'diplomat'
require 'json'
require "slop"

def download_key()
	Diplomat.configuration.url = "http://consul.kenshoo-lab.com"
	dump = Diplomat::Kv.get("eyals-test", recurse: true)
	date = Time.now
	filename = date.strftime("eyals-test_%Y%m%dT%H%M%S.json")
	File.open("#{filename}","w") do |f|
	  f.write(JSON.generate(dump))
	end
end

opts = Slop.parse do |o|
  o.string '-m', '--mode', 'Should be either "download" for saving the key or "upload" to upload it'
  o.string '-h', '--host', 'The consul host name to work with'
  o.string '-c', '--config_file', 'Specify a location for yaml configuration file. If not specified defaults to config.yaml in current folder', default: "config.yaml"
  o.on '-v' '--version', 'print the current consuler version' do
    puts "Consuler by Eyal Stoler v#{VERSION}."
    exit
  end
  o.on '--help', 'Print help' do
  	puts o
  	exit  	
  end 
end

puts case opts[:mode]
when "download"
	download_key
when "upload"
	puts "phi phi phi"
else
	raise ArgumentError, "unknown --mode option \"#{opts[:mode]}\""
end