require 'spec_helper'

describe SqRubyGrep do
  context 'when grep file' do
    let(:path)          { 'test/fixtures/text.txt' }
    let(:bin_path)      { File.expand_path '../../bin/sq_ruby_grep', __FILE__ }
    let(:result)        { Grep.new(pattern: pattern, file_path: path, before_lines: before_lines, after_lines: after_lines).run.first }
    let(:pattern)       { 'needle' }
    let(:original_grep) { "grep #{pattern} #{path} -A #{after_lines} -B #{before_lines}" }
    let(:sq_ruby_grep) { "#{bin_path} #{pattern} #{path} -A #{after_lines} -B #{before_lines} --not-colorize" }

    shared_examples 'origin grep' do
      it 'sq_ruby_grep vs original_grep' do
        expect(`#{sq_ruby_grep}`).to eq  `#{original_grep}`
      end
    end

    context 'when has no context' do
      let(:after_lines)   { 0 }
      let(:before_lines)  { 0 }

      it_behaves_like 'origin grep'
    end

    context 'when has no group separator' do
      let(:after_lines)   { 2 }
      let(:before_lines)  { 2 }

      it_behaves_like 'origin grep'
    end

    context 'when before context intersects prev after context' do
      let(:after_lines)   { 2 }
      let(:before_lines)  { 3 }

      it_behaves_like 'origin grep'
    end

    context 'when before context touch prev after context' do
      let(:after_lines)   { 2 }
      let(:before_lines)  { 3 }

      it_behaves_like 'origin grep'
    end

    context 'when after context is out range of file' do
      let(:after_lines)   { 20 }
      let(:before_lines)  { 2 }

      it_behaves_like 'origin grep'
    end

    context 'when before context is out range of file' do
      let(:after_lines)   { 2 }
      let(:before_lines)  { 20 }

      it_behaves_like 'origin grep'
    end

    context 'when has no after context' do
      let(:after_lines)   { 0 }
      let(:before_lines)  { 1 }

      it_behaves_like 'origin grep'
    end


    context 'when has no before context' do
      let(:after_lines)   { 1 }
      let(:before_lines)  { 0 }

      it_behaves_like 'origin grep'
    end
  end
end
