module Trade
  class Conversion
    FILE_PATH = "data/SAMPLE_RATES.xml"

    def initialize(file_path=FILE_PATH)
      data = File.read file_path
    end

  end # class Conversion
end # module Trade

Trade::Conversion.new
