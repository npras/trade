require "spec_helper"


describe Trade::Conversion do

  before do
    @it = Trade::Conversion.new
  end

  describe '#exchange_rate_recursive' do
    from = 'USD'
    to = 'INR'
    @it.exchange_rate_recursive(from, to).must_equal 55.91
  end

end # describe Trade::Conversion

