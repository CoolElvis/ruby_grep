require 'spec_helper'

describe SqRubyGrep do
  context 'when grep file' do
    let(:lines)        { lines = File.readlines path }
    let(:path)         { 'test/fixtures/lines.txt' }
    let(:after_lines)  { 3 }
    let(:before_lines) { 3 }
    let(:result)       { SqRubyGrep.grep(file_path:path, pattern: pattern, before_lines: before_lines, after_lines: after_lines).first }
    let(:pattern)      { /#{target_line} line/ }

    context 'when the target line at the middle' do

      let(:target_line) { 6 }

      it 'before_context is valid' do
        expect(result.before_context).to eql lines[target_line - before_lines - 1 , before_lines]
      end

      it 'match_line is valid' do
        expect(result.match_line).to eql lines[target_line - 1]
      end

      it 'after_context is valid' do
        expect(result.after_context).to eql lines[target_line, after_lines]
      end

      context 'when after_lines is out scope of file' do
        let(:after_lines) { 30 }

        it 'after_context is valid' do
          expect(result.after_context).to eql lines[target_line, after_lines]
        end

        it 'before_context is valid' do
          expect(result.before_context).to eql lines[target_line - before_lines - 1 , before_lines]
        end
      end

      context 'when before_lines is out scope of file' do
        let(:before_lines) { 30 }

        it 'after_context is valid' do
          expect(result.after_context).to eql  lines[target_line, after_lines]
        end

        it 'before_context is valid' do
          expect(result.before_context).to eql lines[0 , target_line - 1]
        end
      end

    end

    context 'when the target line at the end' do
      let(:target_line) { 12 }

      it 'before_context is valid' do
        expect(result.before_context).to eql lines[target_line - before_lines - 1 , before_lines]
      end

      it 'match_line is valid' do
        expect(result.match_line).to eql lines[target_line - 1]
      end

      it 'after_context is valid' do
        expect(result.after_context).to eql lines[target_line, after_lines]
      end

      context 'when after_lines is out scope of file' do
        let(:after_lines) { 30 }

        it 'after_context is valid' do
          expect(result.after_context).to eql lines[target_line, after_lines]
        end

        it 'before_context is valid' do
          expect(result.before_context).to eql lines[target_line - before_lines - 1 , before_lines]
        end
      end

      context 'when before_lines is out scope of file' do
        let(:before_lines) { 30 }

        it 'after_context is valid' do
          expect(result.after_context).to eql  lines[target_line, after_lines]
        end

        it 'before_context is valid' do
          expect(result.before_context).to eql lines[0 , target_line - 1]
        end
      end

    end

    context 'when the target line at the beginning ' do
      let(:target_line) { 2 }

      it 'before_context is valid' do
        expect(result.before_context).to eql lines[0, 1]
      end

      it 'match_line is valid' do
        expect(result.match_line).to eql lines[target_line - 1]
      end

      it 'after_context is valid' do
        expect(result.after_context).to eql lines[target_line, after_lines]
      end

      context 'when after_lines is out scope of file' do
        let(:after_lines) { 30 }

        it 'after_context is valid' do
          expect(result.after_context).to eql lines[target_line, after_lines]
        end

        it 'before_context is valid' do
          expect(result.before_context).to eql lines[0, target_line - 1]
        end
      end

      context 'when before_lines is out scope of file' do
        let(:before_lines) { 30 }

        it 'after_context is valid' do
          expect(result.after_context).to eql lines[target_line, after_lines]
        end

        it 'before_context is valid' do
          expect(result.before_context).to eql lines[0 , target_line - 1]
        end
      end
    end

  end

end
