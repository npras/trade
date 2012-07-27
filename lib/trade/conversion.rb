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

    #def get_exchange_rate(from, to, result=1.0, prev_froms = [])
      #prev = result
      #prospects = @rates.find_all do |rate|
        #rate.xpath('./from').text == from
      #end

      #fail "Exchange rate Conversion not available!" if prospects.nil?
      ##return -1 if prospects.nil?

      #prospects.each do |prospect|
        #current_to = prospect.xpath('./to').text
        #current_conv = prospect.xpath('conversion').text.to_f

        #if current_to == to
          #return result *= current_conv
        #else
          #if(prev_froms.include?(from))
            #result = prev # resetting 
            #next
          #else
            #result *= current_conv
            #prev_froms << from
            #return get_exchange_rate(current_to, to, result, prev_froms)
          #end
          #result = prev # resetting 
        #end
      #end # prospects.each

    #end # def get_exchange_rate
    
    def get_exchange_rate(from, to, result=1.0, prev_froms=[], ctr=1)
      prev = result
      prospects = @rates.find_all do |rate|
        rate.xpath('./from').text == from
      end

      if prospects.count == 0
        puts "I'm HERE!!"
        fail NoProspectError, "No conversion available for '#{from}' #{ctr}." 
      else
        #puts "Prospect's(#{from}) count: #{prospects.size}"
      end

      # immediately check all prospects for a match
      # before searching recursively
      prospects.each do |prospect|
        if prospect.xpath('./to').text == to
          result *= prospect.xpath('./conversion').text.to_f
          return result
        end
      end

      # check through recursion
      prospects.each do |prospect|
        #result = prev
        current_to = prospect.xpath('./to').text
        current_conv = prospect.xpath('./conversion').text.to_f
        #puts "#{current_to}: :#{current_conv}"
        
        if current_to == to
          return (result * current_conv)
        else
          if(prev_froms.include? from)
            result = prev
            next
          else
            prev_froms << from
            result *= current_conv
            begin
              ctr += 1
              result = get_exchange_rate(current_to, to, result, prev_froms, ctr)
              return result
            rescue NoProspectError
              result = prev
              next
            end
          end
        end
      end # prospects.each

      fail NoProspectError, "Nothing found!"
    end # get_exchange_rate

  end # class Conversion

  class NoProspectError < StandardError
  end
end # module Trade

#p Trade::Conversion.new.get_exchange_rate 'CAD', 'USD'
#debugger
#p Trade::Conversion.new.get_exchange_rate1 'AUD', 'CAD'
#p Trade::Conversion.new.get_exchange_rate1 'USD', 'AUD'
#p Trade::Conversion.new.get_exchange_rate 'USD', 'INR'
#p Trade::Conversion.new.get_exchange_rate 'USD', 'TNR'
