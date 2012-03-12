require 'rudbms/file/block'

class TestBlock < MiniTest::Unit::TestCase

  def setup
    @filename = 'alpha'
    @block_number = 1
    @as_string = "[file #{@filename}, block #{@block_number}]"
    @default_block = Block.new(@filename, @block_number)
  end

  def test_must_initialize_with_filename_and_block_number
    assert_raises(ArgumentError) do
      Block.new
    end
    assert Block.new(@filename, @block_number), 'Could not instantiate Block with two params'
  end

  def test_should_have_filename_attribute
    assert_respond_to(@default_block, :filename, 'Missing attr accessor for filename.')
  end

  def test_should_have_number_attribute
    assert_respond_to(@default_block, :number, 'Missing attr accessor for block number.')
  end

  def test_constructor_should_assign_passed_filname_and_block_number
    filename = 'alpha'
    block_num = 1
    assert_equal(@filename, @default_block.filename, 'Filename does not match initialized value.')
    assert_equal(@block_number, @default_block.number, 'Block number does not match initialized value.')
  end

  def test_string_representation
    assert_equal(@as_string, @default_block.to_s, 'String representation of Block incorrect.')
  end

  def test_blocks_with_differing_filename_or_block_number_should_not_be_considered_equal
    b1 = Block.new(@filename + "foo", @block_number + 1)
    b2 = Block.new(@filename + "foo", @block_number)
    b3 = Block.new(@filename, @block_number + 1)
    refute_equal(@default_block, b1)
    refute_equal(@default_block, b2)
    refute_equal(@default_block, b3)
  end

  def test_blocks_with_same_filename_and_block_number_should_be_considered_equal
    b = Block.new(@filename, @block_number)
    assert_equal(@default_block, b)
  end

end