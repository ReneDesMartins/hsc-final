require "rubygems"
require "sinatra"
require "digest" # For hashing the password

get "/(?:(?<digit1>\d+)-(?<digit2>\d+)-(?<digit3>\d+))?" do
	# If there is an id provided, use it to access the corresponding comic
	id = "#{params[:digit1]}-#{params[:digit2]}-#{params[:digit3]}"
	if id.nil? then
		@image = "#{id}.png"
	else
		Dir.chdir("images/comic")
		# Slice out "." and ".."
		entries = Dir.entries[1, Dir.entries.length-2].sort do
			# The file system is sorted by X-Y-Z-A e.g. 9-10-1-A covers 9.10.1
			# and is the first comic in the series covering that syllabus point.
			|comic1, comic2|
			re = /(\d+)-(\d+)-(\d+)-(\d+)\.png/ # Matches X-Y-Z-A.png
			match1 = comic1.match(re)
			match2 = comic2.match(re)
			[0..3].each {|i| return -1 if match1[i] < match2[i]}
			return 1 # all cases covered
		end
	end
	erb :comics
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

def password_check(password)
	@check_hash = Digest::SHA256.digest password
 	if @check_hash == @hash then
		return true
	else
		return false
	end
end
