module FakeWeb
	def self.fixture_file(filename)
  		return "" if filename == ""
  		file_path = File.expand_path(File.dirname(__FILE__) + "/fixtures/" + filename)
  		File.read(file_path)
	end
	
	def self.register(params)
		filename = params[:filename]
		status = params[:status]
		options = {:body => fixture_file(filename)}
  		options.merge!({:status => status}) unless status.nil?
		url = params[:url]
  		FakeWeb.register_uri(:get, url, options)
	end
end     
