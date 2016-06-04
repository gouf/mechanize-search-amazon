require 'mechanize'
require 'uri'

class Mechanize
  module AmazonSearch
    class Client
      AMAZON_JP_URL = 'http://www.amazon.co.jp'.freeze
      SEARCH_URL = "#{AMAZON_JP_URL}/gp/search?field-keywords=".freeze

      def initialize
        @mechanize = Mechanize.new
      end

      def search(key_word)
        @search_result = @mechanize.get("#{SEARCH_URL}#{URI.escape(key_word)}"))

      private

      def title(search_result)
        search_result.css('h2').first.text
      end
    end
  end
end
