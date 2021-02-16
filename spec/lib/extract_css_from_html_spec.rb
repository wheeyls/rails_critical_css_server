require 'spec_helper'

describe RailsCriticalCssServer::ExtractCssFromHtml do
  describe '#call' do
    let(:html) do
      <<~HTML
        <link rel=\"stylesheet\" media=\"all\" href=\"/assets/foundation-6.css\" /><link rel=\"stylesheet\" media=\"all\" href=\"/assets/nessy/application.css\" /><link rel=\"stylesheet\" media=\"all\" href=\"/assets/products.css?body=1\" />
      HTML
    end

    it 'returns an array of CSS filenames in order' do
      expect(described_class.call(html)).to eq %w[/assets/foundation-6.css
                                                  /assets/nessy/application.css
                                                  /assets/products.css?body=1]
    end
  end
end
