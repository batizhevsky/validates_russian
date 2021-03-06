require 'spec_helper'

describe SnilsFormatValidator do
  before(:all) do
    TestModel.reset_callbacks(:validate)
    TestModel.validates(:field, snils_format: true)
  end

  it 'should be valid for valid values' do
    valid_snilses =  %w{
      11223344595
      67238412306
      001001998
      001001997
    }

    valid_snilses.each do |snils|
      expect(TestModel.new(field: snils)).to be_valid
    end
  end

  it 'should not be valid for invalid values' do
    invalid_snilses =  %w{
       77150100
       67237412306
       67238412307
       11223344594
       78fffffff
    }.push('', ' ', nil, [], {})

    invalid_snilses.each do |snils|
      expect(TestModel.new(field: snils)).to be_invalid
    end
  end
end
