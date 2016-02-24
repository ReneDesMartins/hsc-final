require 'sinatra'

get '/' do
	# Serve up the last comic
	erb :comic
end

get '/cast' do
	# Cast
	erb :cast
end

# Serve up {comic}

not_found do
	halt 404, 'page not found'
end