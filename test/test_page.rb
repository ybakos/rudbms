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

  def test_page_class_string_size_should_equal_size_of_strings_on_platform
    refute_equal('oop'.size, Page.string_size(1), 'Page string_size does not match size of string on platform')
    assert_equal('poop'.size, Page.string_size(4), 'Page string_size does not match size of string on platform')
  end



end