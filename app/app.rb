require 'sinatra'

get '/' do
	# Serve up the last comic
	erb :comic
end

get '/:comic' do
	# Serve up {comic}
end

get '/cast' do
	# Cast
	erb :cast
end

not_found do
	status 404
