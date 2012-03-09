# A reference to a disk block.
# A Block object consists of a filename and a block number.
# It does not hold the contents of the block;
# instead, that is the job of a Page object. (Sciore)
# Translated from simpledb/file/Block.java
class Block

  attr_accessor :filename, :block_number

  def initialize(filename, block_number)
    @filename = filename
    @block_num = block_number
  end

  alias_method :block_number, :number

  def ==(other)
    return filename == other.filename && block_number == other.block_number
  end

  def to_s
    "[file #{filename}, block #{blknum}]"
  end

end