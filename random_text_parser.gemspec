# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'random_text_parser/version'

Gem::Specification.new do |gem|
  gem.name          = "random_text_parser"
#  gem.version       = RandomTextParser::VERSION
  gem.version       = "0.0.2"
  gem.authors       = ["petRUShka"]
  gem.email         = ["petrushkin@yandex.ru"]
#  gem.description   = %q{Parser that allow to generate almost random text from template}
  gem.summary       = %q{Parser that allow to generate almost random text from template}
  gem.homepage    =   'http://github.com/petRUShka/random_text_parser'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency('parslet')
end
