# file/block.rb
# Yong Joseph Bakos
# Translated from simpledb/file/Block.java
#
# A reference to a file block.
# A Block object consists of a filename and a block number.
# It does not hold the contents of the block;
# instead, that is the job of a Page object (Sciore, 2009).
class Block

  attr_accessor :filename, :number

  def initialize(filename, block_number)
    @filename = filename
    @number = block_number
  end

  def ==(other)
    return filename == other.filename && number == other.number
  end

  def to_s
    "[file #{filename}, block #{number}]"
  end

end