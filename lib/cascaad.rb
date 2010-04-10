require "open-uri"
require "json"

module Cascaad
	class BadApiKey < RuntimeError; end
		
	class Client
		BASE_URL='http://openapi.cascaad.com/1/supertweet'

		attr :api_key

		def initialize(api_key)
			@api_key = api_key
		end
		
		def initialize(api_key, command="", *ids)
			@api_key = api_key
			@command = command
			@ids = ids
		end
		
		def show(*ids)
			Client.new(@api_key, "show", ids)
		end

		def related_messages(*ids)
			Client.new(@api_key, "related", ids)
		end

		def from(domain)
			st_url = "#{BASE_URL}/#{@command}.json?api_key=#{api_key}&domain=#{domain}&message=#{@ids.join(',')}"
			begin
				open(st_url) do |response|
					JSON.parse(response.read)
				end
			rescue OpenURI::HTTPError
				raise Cascaad::BadApiKey
			end
		end
	end
end
