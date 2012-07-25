require "nokogiri"

module Trade
  class Conversion

    include Nokogiri

    FILE_PATH = "data/SAMPLE_RATES.xml"

    def initialize(file_path=FILE_PATH)
      @doc = Nokogiri::XML(File.open(file_path))
      p exchange_rate "CAD", "USD"
    end

    def exchange_rate(from, to)
      match = @doc.xpath('//rate').find do |rate|
        (rate.xpath('./from').text == from) &&
          (rate.xpath('./to').text == to)
      end
      match.xpath('conversion').text.to_f
    end

  end # class Conversion
end # module Trade

Trade::Conversion.new
