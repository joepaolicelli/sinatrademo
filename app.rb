require 'sinatra'
require 'erb'

get '/' do
  @arr = Array.new
  theFile = File.open("cake.list")

  theFile.each do |line|
    @arr << line
  end

  theFile.close
  erb :index
end
