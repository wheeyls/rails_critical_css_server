require 'spec_helper'

describe RailsCriticalCssServer::ExtractCssFromHtml do
  subject { RailsCriticalCssServer::ExtractCssFromHtml }

  describe '#call' do
    let(:html) do
      <<-EOF
<link rel=\"stylesheet\" media=\"all\" href=\"/assets/foundation-6.css\" /><link rel=\"stylesheet\" media=\"all\" href=\"/assets/nessy/application.css\" /><link rel=\"stylesheet\" media=\"all\" href=\"/assets/products.css?body=1\" />
      EOF
    end

    it 'returns an array of CSS filenames in order' do
      expect(subject.call(html)).to eq [
        '/assets/foundation-6.css',
        '/assets/nessy/application.css',
        '/assets/products.css?body=1'
      ]
    end
  end
end
