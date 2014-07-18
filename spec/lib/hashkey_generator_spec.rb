require "rails_helper"
require "hashkey_generator"

RSpec.describe HashkeyGenerator, :type => :module do

  let(:generator_class) { class HashkeyGeneratorTest; extend HashkeyGenerator; end }

  context "#concat_params" do
    let(:params)      { { operation: :add, operand_a: 1, operand_b: 2 } }
    let(:expectation) { "operation=add&operand_a=1&operand_b=2" }

    it "can concat a hash as a get url part" do
      expect(generator_class.concat_params(params)).to eq expectation
    end

    it "returns empty string is empty params hash ispassed" do
      expect(generator_class.concat_params({})).to eq ""
    end

    it "omits hash key-pairs that have empty or nil values" do
      expect(generator_class.concat_params({a: nil, b: '', c: 12})).to eq "c=12"
    end
  end

  context "#sort_params" do
    let(:params)      { { operation: :add, operand_a: 1, operand_b: 2 } }
    let(:expectation) { { operand_a: 1, operand_b: 2, operation: :add } }

    it "sorts a hash in alphabetical order of its keys" do
      expect(generator_class.sort_params(params)).to eq expectation
    end
  end

end
