# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rudbms/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Yong Joseph Bakos"]
  gem.email         = ["ybakos@humanoriented.com"]
  gem.description   = %q{A Ruby implementation of Edward Sciore's SimpleDB relational database management system}
  gem.summary       = %q{A Ruby implementation of Edward Sciore's SimpleDB relational database management system}
  gem.homepage      = "http://mines.humanoriented.com/403"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rudbms"
  gem.require_paths = ["lib"]
  gem.version       = Rudbms::VERSION
end
