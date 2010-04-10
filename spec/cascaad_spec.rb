$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

require "spec_helper"
require "rubygems"
require "fakeweb"
require "cascaad"

FakeWeb.allow_net_connect = false

describe "A Cascaad client" do
	it "should be created with APIKEY" do
		client = Cascaad::Client.new 'APIKEY'
		client.api_key.should == 'APIKEY'
	end
	
	context "with a bad api_key" do
		before(:all) do
			@client = Cascaad::Client.new 'BAD_API_KEY'
		end

		it "should raise an exception calling show_messages" do
			reg_bad_url('developer_inactive.html',
				'http://openapi.cascaad.com/1/supertweet/show.json?domain=twitter.com&message=11845310763,11845134434,11843458299&api_key=BAD_API_KEY')
			lambda { 
				@client.show_messages("11845310763","11845134434","11843458299").from("twitter.com") 
			}.should raise_error(Cascaad::BadApiKey)
		end
		it "should raise an exception calling related_messages" do
			reg_bad_url('developer_inactive.html',
				'http://openapi.cascaad.com/1/supertweet/related.json?domain=twitter.com&message=11843458299&api_key=BAD_API_KEY')
			lambda { 
				@client.related_messages("11843458299").from("twitter.com") 
			}.should raise_error(Cascaad::BadApiKey)
		end
	end

	context "with a good api_key" do
		before(:all) do
			@client = Cascaad::Client.new 'GOOD_API_KEY'
		end

		it "should show messages" do
			reg_good_url('show_messages.json',
				'http://openapi.cascaad.com/1/supertweet/show.json?domain=twitter.com&message=11845310763,11845134434,11843458299&api_key=GOOD_API_KEY'
			)
			supertweets = @client.show_messages("11845310763","11845134434","11843458299").from("twitter.com")
			supertweets.size.should == 3
			supertweets.first["supertweet"]["author_id"].should == "816653"
		end

		it "should return related messages" do
		    reg_good_url('related_messages.json',
				'http://openapi.cascaad.com/1/supertweet/related.json?domain=twitter.com&message=9760573348&api_key=GOOD_API_KEY'
			)

			supertweets = @client.related_messages("9760573348").from("twitter.com")
			supertweets.size.should == 3
			supertweets.first["supertweet"]["author_id"].should == "51200175"
		end
		it "should raise BadRequest when show message an empty list of ids" do
			lambda {
				@client.show_messages().from("twitter.com")
			}.should raise_error(Cascaad::BadRequest)
		end
		it "should raise BadRequest when show message for nil" do
			lambda {
				@client.show_messages(nil).from("twitter.com")
			}.should raise_error(Cascaad::BadRequest)
		end
		it "should raise BadRequest when show message for invalid id" do
			lambda {
				@client.show_messages("123", "adc").from("twitter.com")
			}.should raise_error(Cascaad::BadRequest)
		end
	end
end

