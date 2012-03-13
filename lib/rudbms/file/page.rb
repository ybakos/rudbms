# file/page.rb
# Yong Joseph Bakos
# Translated from simpledb/file/Page.java
# 
# The contents of a file block in memory.
# A Page is treated as an array of BLOCK_SIZE bytes.
# There are methods to get/set values into this array,
# and to read/write the contents of this array from/to a file block.
# 
# For an example of how to use Page and Block objects, 
# consider the following code fragment.
# The first portion increments the integer at offset 420 of block 6 of file junk.  
# The second portion stores the string "hello" at offset 20 of a page, 
# and then appends it as a new block of a file. It then reads that block into another page 
# and extracts the value "hello" into variable s.
# <tt>
# p1 = Page.new
# blk = Block.new("junk", 6)
# p1.read(blk)
# n = p1.get_int(420)
# p1.set_int(420, n+1)
# p1.write(blk)
#
# p2 = Page.new
# p2.setString(20, "hello")
# blk = p2.append("junk")
# p3 = Page.new;
# p3.read(blk);
# s = p3.get_string(20);
# </tt>
# (Sciore, 2009)
class Page

  attr_reader :contents

  # The number of bytes in a block.
  # This value is set unreasonably low, so that it is easier to create and tinker
  # with databases having a lot of blocks. A more realistic value would be 4K.
  BLOCK_SIZE = 512

  # The size of an integer in bytes.
  INT_SIZE = 0.size

  # The maximum size, in bytes, of a string of length n.
  # In this system, a string is represented as the encoding of its characters
  # preceded by an integer denoting the number of bytes in this encoding.
  # If Ruby uses the ASCII-8BIT encoding, then each char is stored in one byte,
  # so a string of n characters, has a size of 4 + n bytes.
  # <tt>length</tt>: the size of the string
  # Returns the maximum number of bytes required to store a string of size <tt>length</tt>
  def self.string_size(length)
    return INT_SIZE + length * 'c'.size
  end

  # Creates a new page. Although the constructor takes no arguments,
  # it depends on a FileMgr object that it gets from Server#fileMgr().
  # That object is created during system initialization.
  # Thus this constructor cannot be called until either
  # <tt>Server#init(String)</tt> or
  # <tt>Server#initFileMgr(String)</tt> or
  # <tt>Server#initFileAndLogMgr(String)</tt> or
  # <tt>Server#initFileLogAndBufferMgr(String)</tt>
  # is called first.
  def initialize
    # http://stackoverflow.com/questions/10323/why-doesnt-ruby-have-a-real-stringbuffer-or-stringio
    # http://stackoverflow.com/questions/1211461/what-is-rubys-stringio-class-really
    # http://docs.oracle.com/javase/6/docs/api/java/nio/ByteBuffer.html
    # http://stackoverflow.com/questions/7158124/create-bytebuffer-like-object-in-ruby
    # https://github.com/koraktor/steam-condenser-ruby/blob/master/lib/core_ext/stringio.rb
    @contents = StringIO.new('', 'r+b')
    @filemgr = Server.file_manager
  end

  # Populates the page with the contents of the specified file block.
  def read(block)
    synchronize { @filemgr.read(block, @contents) }
  end
  
  # Writes the contents of the page to the specified file block.
  # <tt>block</tt>: a reference to a file block
  def write(block)
    synchronize { @filemgr.write(block, @contents) }
  end

  # Appends the contents of the page to the specified file.
  # <tt>filename</tt>: the name of the file.
  # Returns a reference to the newly-created file block.
  def append(filename)
    synchronize { return @filemgr.append(filename, @contents) }
  end
  
  # Returns the integer value at a specified offset of the page.
  # If an integer was not stored at that location, 
  # the behavior of the method is unpredictable.
  # <tt>offset</tt>: the byte offset within the page.
  # Returns the integer value at that offset.
  def get_int(offset)
    # synchronize #TODO: Ruby 1.9.3 Mutex.synchronize
    @contents.pos = offset
    # convert the four bytes to a signed integer
    return @contents.read(4).unpack('l')[0]
  end
  
  # Writes an integer to the specified offset on the page.
  # <tt>offset</tt>: the byte offset within the page.
  # <tt>value</tt>: the integer to be written to the page.
  def set_int(offset, value)
    # synchronize #TODO: Ruby 1.9.3 Mutex.synchronize
    @contents.pos = offset
    # convert the value to bytes
    @contents.write [value].pack('L')
  end
  
  # Returns the string value at the specified offset of the page.
  # If a string was not stored at that location,
  # the behavior of the method is unpredictable.
  # <tt>offset</tt>: the byte offset within the page
  # Returns the string value at that offset
  def get_string(offset)
    # synchronize #TODO: Ruby 1.9.3 Mutex.synchronize
    @contents.pos = offset
    return @contents.gets
  end
  
  # Writes a string to the specified offset on the page.
  # <tt>offset</tt>: the byte offset within the page.
  # <tt>value</tt>: the string to be written to the page.
  def set_string(offset, value)
    # synchronize #TODO: Ruby 1.9.3 Mutex.synchronize
    @contents.pos = offset
    @contents << value
  end

  def to_s
    @contents.string
  end

end