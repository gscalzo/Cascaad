$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "spec_helper"
require "rubygems"
require "fakeweb"
require "cascaad"

FakeWeb.allow_net_connect = false

describe "Cascaad client" do
	it "should be created with APIKEY" do
		client = Cascaad::Client.new 'APIKEY'
		client.api_key.should == 'APIKEY'
	end
	
	context "when show_messages called with bad api_key" do
		it "should raise an exception" do
			FakeWeb.register(
				:filename => 'developer_inactive.html',
				:status => ["403", "Forbidden"],
				:url => 'http://openapi.cascaad.com/1/supertweet/show.json?domain=twitter.com&message=11845310763,11845134434,11843458299&api_key=BAD_API_KEY'
			)
			client = Cascaad::Client.new 'BAD_API_KEY'
			lambda { client.show_messages("11845310763","11845134434","11843458299") }.should raise_error(Cascaad::BadApiKey)
		end
	end

	context "when show_messages called with good api_key" do
		it "should return good result" do
			FakeWeb.register(
				:filename => 'show_messages.json',
				:status => ["200", "Ok"],
				:url => 'http://openapi.cascaad.com/1/supertweet/show.json?domain=twitter.com&message=11845310763,11845134434,11843458299&api_key=GOOD_API_KEY'
			)
		
			client = Cascaad::Client.new 'GOOD_API_KEY'
			supertweets = client.show_messages("11845310763","11845134434","11843458299")
			supertweets.size.should == 3
			supertweets.first["supertweet"]["author_id"].should == "816653"

		end
	end
end

