Gem::Specification.new do |s|
  s.name = %q{cascaad}
  s.version = "0.0.1"
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.date = %q{2010-04-12}
  s.authors = ["Giordano Scalzo"]
  s.email = %q{giordano@scalzo.biz}
  s.summary = %q{Wrapper to Cascaad SuperTweet Api.}
  s.homepage = %q{http://github.com/gscalzo/Cascaad}
  s.description = %q{Simple wrapper to Cascaad SuperTweet api: http://cascaad.mashery.com/docs}
  s.files = [ "lib/cascaad.rb", "LICENSE", "Rakefile", "README.rdoc", 
  			  "spec/cascaad_spec.rb", "spec/fixtures/developer_inactive.html", "spec/fixtures/related_messages.json",
			  "spec/fixtures/show_messages.json", "spec/spec.opts", "spec/spec_helper.rb",
			  ]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.has_rdoc = false
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.add_dependency("json", ">= 1.2.3")
end

