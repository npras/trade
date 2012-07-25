require 'minitest/autorun'
require 'minitest/pride'
require 'rr'
require 'pry'
require 'debugger'

class MiniTest::Unit::TestCase
  include RR::Adapters::TestUnit
end

