require "open-uri"

module Cascaad
	class BadApiKey < RuntimeError; end
		
	class Client
		BASE_URL='http://openapi.cascaad.com/1/supertweet'

		attr :api_key

		def initialize(api_key)
			@api_key = api_key
		end
		
		def show_messages(*ids)
			st_url = "#{BASE_URL}/show.json?api_key=#{api_key}&domain=twitter.com&message=#{ids.join(',')}"
			begin
				open(st_url) do |response|
					p response.read
				end
			rescue OpenURI::HTTPError
				raise Cascaad::BadApiKey
			end
		end
	end
end
