require_relative "../lib/html_document.rb"

describe HtmlDocument do
  describe 'meta_keywords' do
    let(:doc) { HtmlDocument.new({}) }
    let(:content) { 'lifestyle' }

    context 'when cached @meta_keywords' do
      it 'returns cached meta_keywords content' do
        doc.instance_variable_set(:@meta_keywords, content)
        expect(doc.meta_keywords).to be content
      end
    end
  end
end
