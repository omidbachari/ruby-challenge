require_relative "../lib/html_document.rb"

describe HtmlDocument do
  describe 'meta_keywords' do
    let(:doc) { HtmlDocument.new({}) }
    let(:content) { 'lifestyle' }
    let(:content_collection) { 'dog cat people' }

    context 'when cached @meta_keywords' do
      it 'returns cached meta_keywords content' do
        doc.instance_variable_set(:@meta_keywords, content)
        expect(doc.meta_keywords).to be content
      end
    end

    context 'when no cached @meta_keywords, with existing meta tag' do
      it 'returns array of content' do
        class ContentMock
        end

        parser = double(parser)
        content_mock = ContentMock.new

        allow(content_mock).to receive(:attribute) { content_collection }
        allow(parser).to receive(:get_meta_tag) { content_mock }

        expect(HtmlDocument.new(parser).meta_keywords).to eq [content_collection]

      end
    end

    context 'when no cached @meta_keywords, but data is falsey' do
      it 'returns empty array' do
        class ContentMock
        end

        parser = double(parser)
        content_mock = ContentMock.new

        allow(content_mock).to receive(:attribute)
        allow(parser).to receive(:get_meta_tag) { content_mock }

        expect(HtmlDocument.new(parser).meta_keywords).to eq []
      end
    end
  end
end
