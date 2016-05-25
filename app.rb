require 'sinatra'
require 'erb'
require 'json'
require 'sinatra/activerecord'
require './environments'
require './models/model'

def per_line(file_name)
  theFile = File.open(file_name)

  theFile.each do |line|
    yield line
  end

  theFile.close
end

get '/*.json' do
  headers \
    "Content-type" => "application/json"

  @hsh = {}
  @count = 1

  per_line("cake.list") { |line|
    @hsh[@count] = line.delete("\n")
    @count += 1
  }

  body erb @hsh.to_json
end

get '/' do
  @arr = Array.new

  per_line("cake.list") { |line| @arr << line }

  erb :index
end
