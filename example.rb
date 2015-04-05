lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sq_ruby_grep'

puts SqRubyGrep.run(file_path:'test/fixtures/text.txt', pattern: /needle/, after_lines: 1, before_lines: 2)
