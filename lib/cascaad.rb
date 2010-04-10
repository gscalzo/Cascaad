require "open-uri"
require "json"

class Array
    def valid_ids_required
		raise Cascaad::BadRequest if(self.empty?)
		self.each do |id|
			raise Cascaad::BadRequest unless id =~ /[0-9]+/
		end
    end
end

module Cascaad
	class BadApiKey < RuntimeError; end
	class BadRequest < RuntimeError; end

	class Client
		BASE_URL='http://openapi.cascaad.com/1/supertweet'

		attr :api_key

		def initialize(api_key)
			@api_key = api_key
		end
		
		def show_messages(*ids)
			ids.valid_ids_required

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

	private
		def initialize(api_key, command="", *ids)
			@api_key = api_key
			@command = command
			@ids = ids
		end
	end
end
