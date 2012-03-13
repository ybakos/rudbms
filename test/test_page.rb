require 'rudbms/file/page'

class TestPage < MiniTest::Unit::TestCase

  def setup
  end

  def test_page_class_should_have_member_BLOCK_SIZE
    refute_nil(Page::BLOCK_SIZE)
  end

  def test_page_class_should_have_member_INT_SIZE_equal_to_size_of_int_on_platform
    assert_equal(0.size, Page::INT_SIZE, 'Page INT_SIZE does not match size of int on platform')
  end

  def test_page_class_string_size_should_equal_size_of_strings_on_platform_plus_size_of_int
    refute_equal('oop'.size + 3.size, Page.string_size(1), 'Page string_size does not match size of string on platform')
    assert_equal('poop'.size + 4.size, Page.string_size(4), 'Page string_size does not match size of string on platform')
  end

  def test_set_int_value_written_to_buffer
    p = Page.new
    p.set_int(0, 2)
    p.contents.pos = 0
    assert_equal 2, p.contents.read(4).unpack('l')[0], 'Did not seem to write expected integer to buffer'
  end

  def test_get_int_value_read_from_buffer
    p = Page.new
    p.contents.write [2].pack('L')
    assert_equal 2, p.get_int(0), 'Did not seem to read expected integer from buffer'
  end

  def test_set_string_value_written_to_buffer
    p = Page.new
    p.set_string(0, 'test')
    p.contents.pos = 0
    assert_equal 'test', p.contents.gets, 'Did not seem to write expected string to buffer'
  end

  def test_get_string_value_read_from_buffer
    p = Page.new
    p.contents << 'test'
    assert_equal 'test', p.get_string(0), 'Did not seem to read expected string from buffer'
  end  

  def test_get_set_integer
    p = Page.new
    p.set_int(20, 2)
    assert_equal 2, p.get_int(20), 'Did not seem to get the set integer'
  end

  def test_get_set_string
    p = Page.new
    p.set_string(20, 'test')
    assert_equal 'test', p.get_string(20), 'Did not seem to get the set string'
  end

end