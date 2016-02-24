require 'sinatra'

get '/' do
	# Serve up the last comic
	erb :comic
end
