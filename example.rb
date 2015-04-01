lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sq_ruby_grep'

SqRubyGrep.grep(file_path:'test/fixtures/text.txt', pattern: /non/, after_lines: 2, before_lines: 2, colorize: true).each do |result|
  p '------------'
  puts result.before_context
  puts '---' + result.match_line
  puts result.after_context
  p '------------'
end

