
require_relative '../myenumerables_disc.rb'

describe Enumerable do
  let(:integer_array) { [1, 2, 3, 4, 5, 6, 7, 8, 9, 10] }
  let(:empty_array) { [nil, nil, nil] }
  let(:a_nill_element_array) { [1, 3, nil, 4, 5] }
  let(:cat_words_array) { %w[cat category catecholamines catastrophe] }
  let(:keys_array) { %w[key key key key] }

  describe '#my_each' do
    it 'works equal to #each method' do
      expect(integer_array.my_each { |x| }).to eql(integer_array.each { |x| })
    end

    it 'Returns Enumerable when no block is given' do
      expect(integer_array.my_each).to be_a Enumerator
    end

    it "doesn't change the original array" do
      expect(integer_array.my_each { |x| }).to eql(integer_array)
    end
  end

  describe '#my_each_with_index' do
    it "Calls block with two arguments, the item and its index,
    for each item in enum.Given arguments are passed through to each()" do
      expect(integer_array.my_each_with_index do |x, i|
               x + i
             end).to eql(integer_array.each_with_index { |x, i| x + i })
    end

    it 'Returns Enumerable when no block is given' do
      expect(integer_array.my_each_with_index).to be_a Enumerator
    end
  end

  describe '#my_select' do
    it 'Returns an array containing all elements of enum for which the given
    block returns a true value.' do
      expect(integer_array.my_select(&:even?)).to eql([2, 4, 6, 8, 10])
    end

    it 'Returns Enumerable when no block is given' do
      expect(integer_array.my_each_with_index).to be_a Enumerator
    end
  end

  describe '#my_all?' do
    it "Passes each element of the collection to the given block.
    The method returns true if the block never returns false or nil." do
      expect(integer_array.my_all? { |x| x < 15 }).to be true
    end

    it "Passes each element of the collection to the given block.
    The method returns false if the block returns a false or nil." do
      expect(integer_array.my_all? { |x| x > 15 }).to be false
    end

    it 'if no block is given returns true when none of the collection members
    are false or nil.' do
      expect(integer_array.my_all?).to be true
    end

    it 'if no block is given returns false when an element of the collection
    members are not false or nil.' do
      expect(a_nill_element_array.my_all?).to be false
    end

    it 'Return true when the pattern matches to all elements' do
      expect(cat_words_array.my_all?(/cat/)).to be true
    end

    it "Return false when the pattern doesn't match with at least an element" do
      expect(cat_words_array.my_all?(/ate/)).to be false
    end

    it 'Return true if all the elements are from the same class as the
    parameter' do
      expect(integer_array.my_all?(Integer)).to be true
    end

    it 'Return false if an element is from a different class as the
    parameter' do
      expect(integer_array.my_all?(String)).to be false
    end

    it 'Return true if all of the items match the parameter' do
      expect(keys_array.my_all?('key')).to be true
    end

    it "Return false if at least one of the items doesn't match the
    parameter" do
      expect(cat_words_array.my_all?('key')).to be false
    end
  end
  describe '#my_any' do
    it "Passes each element of the collection to the given block.
    The method returns true if any of element the block returns a truthy." do
      expect(integer_array.my_any? { |x| x > 5 }).to be true
    end

    it "Passes each element of the collection to the given block.
    The method returns false if the block returns always return
    false or nil" do
      expect(integer_array.my_any? { |x| x > 15 }).to be false
    end

    it 'if no block is given returns false when all of the collection members
    are false or nil.' do
      expect(empty_array.my_any?).to be false
    end

    it 'if no block is given returns true when at least an element of the
    collection members is truthy.' do
      expect(a_nill_element_array.my_any?).to be true
    end

    it 'Return true when the pattern matches to at least one element' do
      expect(cat_words_array.my_any?(/ate/)).to be true
    end

    it "Return false when the pattern doesn't match with any element" do
      expect(cat_words_array.my_any?(/ztr/)).to be false
    end

    it 'Return false if none of the elements are from the same class as the
    parameter' do
      expect(integer_array.my_any?(Regexp)).to be false
    end

    it 'Return true if an element is from the same class as the parameter' do
      expect(a_nill_element_array.my_any?(Numeric)).to be true
    end

    it 'Return false if none of the items match the parameter' do
      expect(cat_words_array.my_any?('catfish')).to be false
    end

    it 'Return true if at least one of the items match the parameter' do
      expect(cat_words_array.my_any?('cat')).to be true
    end
  end
  describe '#my_none' do
    it "Passes each element of the collection to the given block.
    The method returns true if the block always returns false or nil." do
      expect(integer_array.my_none? { |x| x > 15 }).to be true
    end

    it "Passes each element of the collection to the given block.
    The method returns false if the block returns at least a truthy" do
      expect(integer_array.my_none? { |x| x > 5 }).to be false
    end

    it 'if no block is given returns true when all of the collection members are
     false or nil.' do
      expect(empty_array.my_none?).to be true
    end

    it 'if no block is given returns false when at least an element of the
    collection members is not false or nil.' do
      expect(a_nill_element_array.my_none?).to be false
    end

    it 'Return false when the pattern matches to at least one element' do
      expect(cat_words_array.my_none?(/ate/)).to be false
    end

    it "Return true when the pattern doesn't match with any element" do
      expect(cat_words_array.my_none?(/ztr/)).to be true
    end

    it 'Return true if none of the elements are from the same class as the
    parameter' do
      expect(integer_array.my_none?(Regexp)).to be true
    end

    it 'Return false if an element is from the same class as the parameter' do
      expect(a_nill_element_array.my_none?(Numeric)).to be false
    end

    it 'Return true if none of the items match the parameter' do
      expect(cat_words_array.my_none?('catfish')).to be true
    end

    it 'Return false if at least one of the items match the parameter' do
      expect(keys_array.my_none?('key')).to be false
    end
  end

  describe '#my_count' do
    it 'returns the numeber of items that pass the code in the block' do
      expect(integer_array.my_count { |x| x > 5 }).to eq(5)
    end

    it 'return the number of items equals to the argument' do
      expect(keys_array.my_count('key')).to eq(4)
    end

    it 'returns the number of items in the array if no block or argument is
    passed' do
      expect(integer_array.my_count).to eq(10)
    end
  end

  describe '#my_map' do
    it 'Returns Enumerable when no block is given' do
      expect(integer_array.my_map).to be_a Enumerator
    end

    it 'Returns a new array with the results of running block' do
      expect(integer_array.my_map { |x| x + 10 }).to eq(integer_array.map do |x|
                                                          x + 10
                                                        end)
    end
  end

  describe '#my_inject' do
    it 'Combines all elements of enum by applying a binary operation, specified
    by a block' do
      expect(integer_array.my_inject { |sum, n| sum + n }).to eq(55)
    end

    it 'If you specify a symbol instead, then each element in the collection
    will be passed to the named method' do
      expect(integer_array.my_inject(:*)).to eq(integer_array.inject(:*))
    end

    it 'can take an explicitly specify an initial value with a block' do
      expect(integer_array.my_inject(10) { |sum, n| sum + n }). to eq(65)
    end

    it 'can take an explicitly specify an initial value with symbol' do
      expect(integer_array.my_inject(3, :*)).to eq(integer_array.inject(3, :*))
    end
  end
end
