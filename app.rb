require 'sinatra'
require 'erb'
require 'json'

get '/*.json' do
  headers \
    "Content-type" => "application/json"

  @hsh = {}

  count = 1

  theFile = File.open("cake.list")

  theFile.each do |line|
    @hsh[count] = line.delete("\n")
    count += 1
  end

  theFile.close

  body erb @hsh.to_json
end

get '/' do
  @arr = Array.new

  theFile = File.open("cake.list")

  theFile.each do |line|
    @arr << line
  end

  theFile.close

  erb :index
end
