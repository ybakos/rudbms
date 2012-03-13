#!/usr/bin/env ruby




# Sketch: Using StringIO as a buffer in Page class. Neato!

# require 'stringio'

# buffer = StringIO.new('', 'r+b')
# puts buffer.pos
# buffer.write [72].pack('L')
# puts buffer.pos
# buffer.write [73].pack('L')
# puts buffer.pos
# puts buffer.string

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