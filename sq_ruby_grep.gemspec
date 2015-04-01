# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sq_ruby_grep/version'

Gem::Specification.new do |spec|
  spec.name          = "sq_ruby_grep"
  spec.version       = SqRubyGrep::VERSION
  spec.authors       = ["coolelvis"]
  spec.email         = ["elvisplus2@gmail.com"]
  spec.summary       = %q{It just the training project for SQ interview.}
  spec.description   = %q{It just the training project for SQ interview.}
  spec.homepage      = "https://github.com/CoolElvis/ruby_grep.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
