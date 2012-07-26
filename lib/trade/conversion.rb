require "nokogiri"
require "debugger"

module Trade
  class Conversion

    include Nokogiri

    #FILE_PATH = "data/SAMPLE_RATES.xml"
    FILE_PATH = "data/RATES.xml"

    def initialize(file_path=FILE_PATH)
      @doc = Nokogiri::XML(File.open(file_path))
      @rates = @doc.xpath('//rate')
      #p exchange_rate "CAD", "USD"
    end

    #def get_exchange_rate(from, to, result=1.0)
      #prospect = @rates.find do |rate|
        #rate.xpath('./from').text == from
      #end

      #fail "Exchange rate Conversion not available!" if prospect.nil?
      
      #current_to = prospect.xpath('./to').text
      #current_conv = prospect.xpath('conversion').text.to_f

      #if current_to == to
        #return result *= current_conv
      #else
        #result *= current_conv
        #return get_exchange_rate(current_to, to, result)
      #end
    #end

    def get_exchange_rate(from, to, result=1.0)
      prospects = @rates.find_all do |rate|
        rate.xpath('./from').text == from
      end

      fail "Exchange rate Conversion not available!" if prospects.nil?
      #return -1 if prospects.nil?
      
      prospects.each do |prospect|
        current_to = prospect.xpath('./to').text
        current_conv = prospect.xpath('conversion').text.to_f

        if current_to == to
          return result *= current_conv
        else
          result *= current_conv
          return get_exchange_rate(current_to, to, result)
        end
      end
    end # def get_exchange_rate

  end # class Conversion
end # module Trade

#p Trade::Conversion.new.get_exchange_rate 'CAD', 'USD'
#debugger
p Trade::Conversion.new.get_exchange_rate 'AUD', 'EUR'
#p Trade::Conversion.new.get_exchange_rate 'USD', 'TNR'
