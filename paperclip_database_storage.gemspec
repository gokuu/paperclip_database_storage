$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require 'paperclip_database_storage/version'

Gem::Specification.new do |s|
  s.name = 'paperclip_database_storage'
  s.version = PaperclipDatabaseStorage::VERSION

  s.authors = ['Pedro Rodrigues']
  s.date = '2012-10-01'
  s.summary = 'Database storage support for paperclip file attachment plugin'
  s.description = 'Adds support for storing the contents of files attachment via paperclip plugin on the database'
  s.email = 'pedro@bbde.org'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
  s.required_ruby_version = ">= 1.9.2"

  s.homepage = 'http://github.com/gokuu/paperclip_database_storage'

  s.add_dependency 'paperclip', [">= 3.0.0"]

  s.license = 'MIT'
end