require "rubygems"
require "sinatra"
require "digest" # For hashing the password

def password_check(password)
	@check_hash = Digest::SHA256.digest password
 	if @check_hash == @hash then
		return true
	else
		return false
	end
end

get "/admin" do
	# Set password here
	@password = "ThisIsThePassword"
	@hash = Digest::SHA256.digest @password
	@access_granted = false
	erb :admin
end

post "/admin" do
	# Check password
	@access_granted = password_check(params[:pwd])
end
