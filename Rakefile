require 'rubygems'
require 'rubygems/gem_runner'
require 'spec/rake/spectask'
 
desc "Run all specs"
Spec::Rake::SpecTask.new(:default) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
end

