require "csv"

module Trade
  class Transaction

    #FILE_PATH = 'data/SAMPLE_TRANS.csv'
    FILE_PATH = 'data/TRANS.csv'

    def initialize(file_path=FILE_PATH)
      @rows = CSV.read(file_path, headers: true)
      #p get_sku_sales 'DM1182'
    end

    # Example input:
    #   'DM1182'
    # Example output:
    #   ["19.68 AUD", "58.58 AUD", "54.64 USD"] 
    def get_sku_sales(sku_item)
      total_sales = []
      sku_values = @rows.values_at("sku").flatten
      amount_values = @rows.values_at("amount").flatten
      sku_values.each_with_index do |item, index|
        if item == sku_item
          # dumbest mistake
          #total_sales << @rows.values_at("amount").flatten[index]
          total_sales << amount_values[index]
        end
      end
      total_sales
    end

  end # class Transaction
end # module Trade

#Trade::Transaction.new
