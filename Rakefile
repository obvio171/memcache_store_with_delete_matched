require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'spec'

desc 'Default: run spec tests.'
task :default => :spec

desc "Run all specs"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_files = FileList['spec/**/*_spec.rb']
  t.spec_opts = ['--options', 'spec/spec.opts']
end

desc 'Generate documentation for the mem_cache_store_with_delete_matched plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = 'mem_cache_store_with_delete_matched'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end