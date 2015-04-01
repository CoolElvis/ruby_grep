require 'sq_ruby_grep/version'
require 'ring_buffer'
require 'sq_ruby_grep/parser'

module SqRubyGrep

  Result = Struct.new(:match_line, :before_context, :after_context)

  def self.run
    resuts = grep(Parser.parse(ARGV))
    resuts.each do |result|
      puts '--'
      puts result.before_context
      puts result.match_line
      puts result.after_context
    end

    puts '----'
    puts "Line count: #{resuts.count}"
  end

  def self.grep(file_path:, pattern:, after_lines: 0, before_lines: 0, colorize: false)
    results = []

    buffer           = RingBuffer.new(after_lines + before_lines + 1)
    current_position = 0

    File.open(file_path, 'r') do |file|
      file.each_line do |line|
        buffer << line
        current_position += 1

        offset = buffer.size - after_lines - 1

        if current_position > after_lines && buffer[offset].match(pattern)
          match_line = buffer[offset]
          match_line = self.colorize(match_line, pattern) if colorize

          result = Result.new(match_line, buffer[0, offset], buffer[offset + 1, after_lines])

          results << result
        end
      end

      offset = (buffer.size - after_lines) > 0 ? (buffer.size - after_lines) : 0

      buffer[offset, after_lines].each_with_index do |line, i|
        if line.match(pattern)
          before_offset = (offset + i) > before_lines ? (offset + i - before_lines) : 0
          _before_lines = (offset + i) > before_lines ? before_lines : (offset + i)

          line = colorize(line, pattern) if colorize

          result = Result.new(line, buffer[before_offset, _before_lines], buffer[i + offset + 1, after_lines])

          results << result
        end
      end

    end

    results
  end

  def self.colorize(string, pattern)
    string.gsub(/(#{pattern})/, "\e[0;33m\\1\033[0m")
  end


end
