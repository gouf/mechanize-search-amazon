require 'mechanize'
require 'uri'

class Mechanize
  module AmazonSearch
    class Client
      AMAZON_JP_URL = 'http://www.amazon.co.jp'.freeze
      SEARCH_URL = "#{AMAZON_JP_URL}/gp/search?field-keywords=".freeze

      def initialize(limit = 10)
        raise 'Not a correct number (n < 0)' if limit.to_i < 0
        @limit = (0..limit).to_a
        @mechanize = Mechanize.new
      end

      def search(key_word)
        @search_result = @mechanize.get("#{SEARCH_URL}#{URI.escape(key_word)}"))

      private

      def title(search_result)
        search_result.css('h2').first.text
      end

      def href(search_result)
        product_code = search_result.css('a.s-access-detail-page')
                                    .first
                                    .attributes['href']
                                    .value
                                    .match(%r{/dp/\d+})
                                    .to_s
        "#{AMAZON_JP_URL}#{product_code}"
      end

      def price(search_result)
        search_result.css('span.s-price')
                     .first
                     .text
                     .gsub(/[￥,]/, '')
                     .strip
                     .to_i
      end
    end
  end
end
