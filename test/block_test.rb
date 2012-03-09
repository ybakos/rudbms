require_relative 'test_helper'
require_relative '../lib/rudbms/file/block'

class BlockTest < MiniTest::Unit::TestCase

  def setup
    @filename = 'alpha'
    @block_number = 1
    @as_string = "[file #{@filename}, block #{@block_number}]"
  end

  def test_must_initialize_with_filename_and_block_number
    assert_raises(ArgumentError) do
      Block.new
    end
    assert Block.new(@filename, @block_number), 'Could not instantiate Block with two params'
  end

  def test_should_have_filename_attribute
    b = Block.new(@filename, @block_number)
    assert_respond_to(b, :filename, 'Missing attr accessor for filename.')
  end

  def test_should_have_block_number_attribute
    b = Block.new(@filename, @block_number)
    assert_respond_to(b, :block_number, 'Missing attr accessor for block number.')
  end

  def test_constructor_should_assign_passed_filname_and_block_number
    filename = 'alpha'
    block_num = 1
    b = Block.new(@filename, @block_number)
    assert_equal(@filename, b.filename, 'Filename does not match initialized value.')
    assert_equal(@block_number, b.block_number, 'Block number does not match initialized value.')
  end

  def test_should_have_number_attribute_that_returns_block_number
    b = Block.new(@filename, @block_number)
    assert_respond_to(b, :number, 'Missing attr accessor for number.')
    assert_equal(b.block_number, b.number, 'Block number does not match initialized value.')    
  end

  def test_string_representation
    b = Block.new(@filename, @block_number)
    assert_equal(@as_string, b.to_s, 'String representation of Block incorrect.')
  end

  def test_blocks_with_differing_filename_or_block_number_should_not_be_considered_equal
    b = Block.new(@filename, @block_number)
    b2 = Block.new(@filename + "foo", @block_number + 1)
    b3 = Block.new(@filename + "foo", @block_number)
    b4 = Block.new(@filename, @block_number + 1)
    refute_equal(b, b2)
    refute_equal(b, b3)
    refute_equal(b, b4)
  end

  def test_blocks_with_same_filename_and_block_number_should_be_considered_equal
    b = Block.new(@filename, @block_number)
    b2 = Block.new(@filename, @block_number)
    assert_equal(b, b2)
  end

end