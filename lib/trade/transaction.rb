require "csv"

module Trade
  class Transaction

    FILE_PATH = 'data/SAMPLE_TRANS.csv'

    def initialize(file_path=FILE_PATH)
      @rows = CSV.read(file_path, headers: true)
      total =  get_sku_total_cost "DM1182"
      p sum_it_up total
    end

    def get_sku_total_cost(sku_item)
      total= []
      @rows.values_at("sku").flatten.each_with_index do |item, index|
        if item == sku_item
          total << @rows.values_at("amount").flatten[index]
        end
      end
      total
    end

    # Example:
    #  input (Array): ["19.68 AUD", "58.58 AUD", "54.64 USD"] 
    #   output (Float): 132.9
    def sum_it_up(arr)
      total = arr.inject(0) do |sum, a|
        sum + a.to_f
      end
      (total * 100).round/100.0
    end

  end # class Transaction
end # module Trade

Trade::Transaction.new
