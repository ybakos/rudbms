# file/page.rb
# Yong Joseph Bakos
# Translated from simpledb/file/Page.java
# 
# The contents of a disk block in memory.
# A page is treated as an array of BLOCK_SIZE bytes.
# There are methods to get/set values into this array,
# and to read/write the contents of this array to a disk block.
# 
# For an example of how to use Page and Block objects, 
# consider the following code fragment.  
# The first portion increments the integer at offset 792 of block 6 of file junk.  
# The second portion stores the string "hello" at offset 20 of a page, 
# and then appends it to a new block of the file.  
# It then reads that block into another page 
# and extracts the value "hello" into variable s.
#--
# TODO: update this Java example to the Ruby implementation.
#++
# <tt>
# Page p1 = new Page();
# Block blk = new Block("junk", 6);
# p1.read(blk);
# int n = p1.getInt(792);
# p1.setInt(792, n+1);
# p1.write(blk);
#
# Page p2 = new Page();
# p2.setString(20, "hello");
# blk = p2.append("junk");
# Page p3 = new Page();
# p3.read(blk);
# String s = p3.getString(20);
# </tt>
# (Edward Sciore)
class Page

  # The number of bytes in a block.
  # This value is set unreasonably low, so that it is easier to create and test
  # databases having a lot of blocks. A more realistic value would be 4K.
  BLOCK_SIZE = 400

  # The size of an integer in bytes.
  INT_SIZE = 0.size

  # The maximum size, in bytes, of a string of length n.
  # A string is represented as the encoding of its characters,
  # preceded by an integer denoting the number of bytes in this encoding.
  # If the JVM uses the US-ASCII encoding, then each char
  # is stored in one byte, so a string of n characters
  # has a size of 4+n bytes.
  # <tt>length</tt>: the size of the string
  # Returns the maximum number of bytes required to store a string of size <tt>length</tt>
  def self.string_size(length)
    return length * 'c'.size
  end

  # Creates a new page.  Although the constructor takes no arguments,
  # it depends on a FileMgr object that it gets from SimpleDB#fileMgr().
  # That object is created during system initialization.
  # Thus this constructor cannot be called until either
  # <tt>SimpleDB#init(String)</tt> or
  # <tt>SimpleDB#initFileMgr(String)</tt> or
  # <tt>SimpleDB#initFileAndLogMgr(String)</tt> or
  # <tt>SimpleDB#initFileLogAndBufferMgr(String)</tt>
  # is called first.
  def initialize
    @contents = ByteBuffer.allocate_direct(BLOCK_SIZE) #TODO
                                                       # http://stackoverflow.com/questions/10323/why-doesnt-ruby-have-a-real-stringbuffer-or-stringio
                                                       # http://stackoverflow.com/questions/1211461/what-is-rubys-stringio-class-really
                                                       # http://docs.oracle.com/javase/6/docs/api/java/nio/ByteBuffer.html
                                                       # http://stackoverflow.com/questions/7158124/create-bytebuffer-like-object-in-ruby
    @filemgr = SimpleDB.file_mgr #TODO
  end

  # Populates the page with the contents of the specified disk block.
  def read(block)
    synchronize { @filemgr.read(block, @contents) }
  end
  
  # Writes the contents of the page to the specified disk block.
  # <tt>block</tt>: a reference to a disk block
  def write(block)
    synchronize { @filemgr.write(block, @contents) }
  end

  # Appends the contents of the page to the specified file.
  # <tt>filename</tt>: the name of the file.
  # Returns a reference to the newly-created disk block.
  def append(filename)
    synchronize { return filemgr.append(filename, @contents) }
  end
  
  # Returns the integer value at a specified offset of the page.
  # If an integer was not stored at that location, 
  # the behavior of the method is unpredictable.
  # <tt>offset</tt>: the byte offset within the page.
  # Returns the integer value at that offset.
  def get_int(offset)
    synchronize do
      @contents.position(offset)
      return @contents.get_int
    end
  end
  
  # Writes an integer to the specified offset on the page.
  # <tt>offset</tt>: the byte offset within the page.
  # <tt>value</tt>: the integer to be written to the page.
  def set_int(offset, value)
    synchronize do
      @contents.position(offset)
      @contents.put_int(value)
    end
  end
  
  # Returns the string value at the specified offset of the page.
  # If a string was not stored at that location,
  # the behavior of the method is unpredictable.
  # <tt>offset</tt>: the byte offset within the page
  # Returns the string value at that offset
  def get_string(offset)
    synchronize do
      @contents.position(offset)
      len = @contents.get_int()
      return String.new(@contents.get([]))
    end
  end
  
  # Writes a string to the specified offset on the page.
  # <tt>offset</tt>: the byte offset within the page.
  # <tt>value</tt>: the string to be written to the page.
  def set_string(offset, value)
    synchronize do
      @contents.position(offset)
      @contents.put_int(value.length)
      @contents.put(value)
    end
  end

  def to_s
    @contents.string
  end

end