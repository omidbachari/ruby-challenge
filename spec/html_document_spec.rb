require_relative '../lib/html_document.rb'

describe HtmlDocument do
  describe '#meta_keywords' do
    let(:parser) { double('Parser') }
    let(:tag) { double('Tag') }
    let(:content_collection) { 'dog, cat, people' }
    let(:spacey_content_collection) { 'dog,              cat, people ' }

    before do
      allow(parser).to receive(:get_meta_tag) { tag }
    end

    context 'when cached @meta_keywords' do
      it 'returns cached meta_keywords content' do
        doc = HtmlDocument.new(parser)
        doc.instance_variable_set(:@meta_keywords, content_collection)

        expect(doc.meta_keywords).to be content_collection
      end
    end
    context 'when no cached meta_keywords' do
      context 'and tag' do
        context 'is truthy' do
          it 'returns array of content' do
            allow(tag).to receive(:attribute) { content_collection }
            expect(
              HtmlDocument.new(parser).meta_keywords
            ).to eq %w(dog cat people)
          end
          it 'successfully strips whitespace' do
            allow(tag).to receive(:attribute) { spacey_content_collection }
            expect(
              HtmlDocument.new(parser).meta_keywords
            ).to eq %w(dog cat people)
          end
        end

        context 'is falsey' do
          it 'returns empty array' do
            allow(tag).to receive(:attribute)
            expect(HtmlDocument.new(parser).meta_keywords).to eq []
          end
        end
      end

      context 'and content' do
        context 'is falsey' do
          it 'returns an empty array' do
            allow(tag).to receive(:attribute) { false }
            expect(HtmlDocument.new(parser).meta_keywords).to eq []
          end
        end
      end
    end
  end
end
