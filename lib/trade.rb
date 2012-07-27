require_relative "trade/version"
require_relative "./trade/conversion"
require_relative "./trade/transaction"

require "bigdecimal"


module Trade
  class Sales

    ITEM = 'DM1182'
    CURRENCY = 'USD'

    def initialize(item=ITEM, currency=CURRENCY)
      @item, @currency = item, currency
    end

    def calculate
      sales = Trade::Transaction.new.get_sku_sales(@item)
      #p sales.size
      conv = Trade::Conversion.new
      total = 0.0

      sales.each do |sale|
        amount, currency = sale.split
        #p "#{amount}: #{currency}"
        if currency == @currency
          total += amount.to_f
        else
          total += (amount.to_f * conv.get_exchange_rate(currency, @currency))
        end
      end
      #total
      banker_rounding(total)
    end # def calculate

    def banker_rounding(num)
      # expected 134.22
      # got 134.23
      # BigDecimal is wrong!
      # For RATES and TRANS data, the answer I got was:
      # 59482.51855709883 
      BigDecimal.new(num.to_s).round(2, BigDecimal::ROUND_HALF_EVEN).to_f
    end

  end # class Sales
end # module Trade

p Trade::Sales.new.calculate
#Trade::Sales.new.banker_rounding
