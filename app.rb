require 'sinatra'

get '/' do
	# Serve up the last comic
	erb :comic
end

get '/:comic' do
	# Serve up {comic}
end

not_found do
	status 404
