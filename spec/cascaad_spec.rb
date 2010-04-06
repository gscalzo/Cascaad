$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "cascaad"

describe "Cascaad client" do
	it "should be created with APIKEY" do
		client = Cascaad::Client.new 'APIKEY'
		client.api_key.should == 'APIKEY'
	end
end

