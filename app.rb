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

def store_cakes_from(file_name)
  per_line(file_name) { |line|
    frmt_line = line.delete("\n")

    unless Cake.exists?(cake_name: frmt_line)
      c = Cake.create(cake_name: frmt_line)
    end
  }
end

def get_cakes
  Cake.find_each do |cake|
    cn = cake.cake_name
    yield cn
  end
end

get '/*.json' do
  headers \
    "Content-type" => "application/json"

  store_cakes_from "cake.list"

  @hsh = {}
  @count = 1

  get_cakes { |line|
    @hsh[@count] = line.delete("\n")
    @count += 1
  }

  body erb @hsh.to_json
end

get '/' do
  store_cakes_from "cake.list"

  @arr = Array.new

  get_cakes { |line|
    @arr << line
  }

  erb :index
end
