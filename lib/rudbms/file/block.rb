# file/block.rb
# Yong Joseph Bakos
# Translated from simpledb/file/Block.java
#
# A reference to a disk block.
# A Block object consists of a filename and a block number.
# It does not hold the contents of the block;
# instead, that is the job of a Page object. (Sciore)
class Block

  attr_accessor :filename, :block_number
  alias_method :number, :block_number

  def initialize(filename, block_number)
    @filename = filename
    @block_number = block_number
  end

  def ==(other)
    return filename == other.filename && block_number == other.block_number
  end

  def to_s
    "[file #{filename}, block #{block_number}]"
  end

end