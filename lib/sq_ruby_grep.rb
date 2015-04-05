require 'sq_ruby_grep/version'
require 'sq_ruby_grep/ring_buffer'
require 'sq_ruby_grep/parser'

module SqRubyGrep


  def self.run(pattern:, file_path:, after_lines: 0, before_lines: 0, colorize: true)
    result = []

    File.open(file_path, 'r') do |file|
      current_position, last_match_position = 0, 0
      buffer = RingBuffer.new after_lines + before_lines
      f = false
      was_matches = false
      file.each_line do |line|
        current_position += 1

        if after_lines + before_lines > 0
          if line.match(pattern)
            if was_matches
              if (current_position - last_match_position) > after_lines + before_lines + 1
                result << (colorize ? "\e[0;36m--\033[0m" : "--")
                result.concat buffer.last(before_lines)
              else
                result.concat buffer
              end
            else
              result.concat buffer.last(before_lines)
            end

            result << (colorize ? line.gsub(/(#{pattern})/, "\e[01;31m\\1\033[0m") : line)
            f = false
            was_matches = true
            buffer.clear
            last_match_position = current_position
          else
            buffer << line
          end

          if (current_position - last_match_position) == after_lines + before_lines && was_matches
            result.concat buffer.shift(after_lines)
            # result.concat buffer.last(before_lines)
            f = true
          end
        else
          if line.match(pattern)
            result << (colorize ? line.gsub(/(#{pattern})/, "\e[01;31m\\1\033[0m") : line)
          end
        end
      end

      result.concat buffer.first(after_lines) unless f
    end

    result
  end


end
