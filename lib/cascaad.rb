module Cascaad
	class Client
		attr :api_key

		def initialize(api_key)
			@api_key = api_key
		end
	end
end
