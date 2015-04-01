require 'optparse'

module RubyGrep
  class Parser
    def self.parse(options)
      args = Hash.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = 'RubyGrep searches the named input FILE for lines containing a match to the given PATTERN.'
        opts.banner = 'Usage: ruby_grep [FILE] [options]'

        opts.on('-e PATTERN', '--regex=PATTERN', String, 'Use PATTERN as the pattern.') do |pattern|
          args[:pattern] = pattern
        end

        opts.on('-A NUM', '--after-context=NUM', Integer, 'Print NUM lines of trailing context after matching lines.') do |n|
          args[:after_lines] = n
        end

        opts.on('-B NUM', '--before-context=NUM', Integer, 'Print NUM line of leading context before matching lines.') do |n|
          args[:before_lines] = n
        end

        opts.on('-c', '--colorize', 'Colorize matches') do
          args[:colorize] = true
        end

        opts.on('-h', '--help', 'Prints this help') do
          puts opts
          exit
        end

      end

      opt_parser.parse!(options)

      args[:file_path] = ARGV.shift

      if args[:file_path].to_s.empty? || args[:pattern].to_s.empty?
        puts opt_parser
        exit
      end

      return args
    end
  end
end
