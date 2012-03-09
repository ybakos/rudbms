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
# <pre>
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
# </pre>
# (Edward Sciore)
class Page

end