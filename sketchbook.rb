#!/usr/bin/env ruby




# Sketch: Using StringIO as a buffer in Page class. Neato!

# require 'stringio'

# buffer = StringIO.new('', 'r+b')
# buffer.pos = 0
# buffer << 'howdy!'
# buffer.pos = 0
# buffer.write [72].pack('L')
# buffer.pos = 0
# puts buffer.to_a.to_s

# buffer.pos = 256
# buffer.write [73].pack('L')
# buffer.rewind
# puts buffer.to_a.to_s
# puts buffer.string
# puts buffer.size

# buffer = StringIO.new('', 'r+b')
# buffer.write [72].pack('L')
# puts buffer.string == "H"

# puts buffer.pos
# buffer.write [72].pack('l')
# puts buffer.pos
# buffer.write [73].pack('l')
# puts buffer.pos
# puts buffer.string == 'HI'
# #$stdout.syswrite buffer.string.to_a

# buffer.pos = 0
# puts buffer.getc
# puts buffer.getc == "\x00"
# puts buffer.getc
# puts buffer.getc
# puts buffer.getc
# puts buffer.getc
# puts buffer.getc
# puts buffer.getc
# puts buffer.getc

# puts "\x00".to_i

# buffer.rewind

# puts buffer.to_a.to_s

#puts buffer.string.unpack('l')[0]


# buffer.pos = 0
# puts buffer.read(4).unpack('l')[0]
# puts buffer.read(4).unpack('l')[0]
# puts buffer.pos

# buffer << 'test'
# puts buffer.pos

# buffer.pos = 8
# puts buffer.gets#("\0")#[0..-1] # read(4).unpack('Z')#[0]

# puts buffer.pos

# buffer.write [23].pack('L')
# puts buffer.pos

# buffer.pos = 8
# puts buffer.gets#("\0")#[0..-1] # read(4).unpack('Z')#[0]

# buffer.pos = 12
# puts buffer.read(4).unpack('l')[0]

