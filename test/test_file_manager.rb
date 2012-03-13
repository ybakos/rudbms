require 'rudbms/file/file_manager'

class TestFileManager < MiniTest::Unit::TestCase

  def setup
    @dbname = 'testdb'
  end

  def teardown
    FileUtils.rm_rf(@dbname) if File.exists?(@dbname)
  end

  def test_must_initialize_with_dbname
    assert_raises(ArgumentError) do
      FileManager.new
    end
    assert FileManager.new(@dbname), 'Could not instantiate FileManager with one param.'
  end

  def test_has_accessor_is_new?
    FileManager.new(@dbname).respond_to? :is_new?
  end

  def test_initialization_should_create_new_directory_when_nonexistent
    refute File.exists?(@dbname)
    f = FileManager.new(@dbname)
    assert File.exists?(@dbname), "FileManager did not create directory #{@dbname}."
  end

  def test_should_consider_itself_new_if_no_named_directory_exists
    refute File.exists?(@dbname)
    assert FileManager.new(@dbname).is_new?, 'Instance does not consider itself new.'
  end

  def test_should_not_consider_itself_new_when_named_directory_exists
    Dir.mkdir(@dbname)
    assert File.exists?(@dbname)
    refute FileManager.new(@dbname).is_new?, 'Instance does not consider itself new.'
  end

  def test_should_delete_existing_temp_files_in_directory
    Dir.mkdir(@dbname)
    temp_filenames = 2.times.map {|i| "#{@dbname}/temp#{i}.test" }
    FileUtils.touch(temp_filenames)
    FileManager.new(@dbname)
    temp_filenames.each { |f| refute File.exists?(f), "Temp file was still present in #{@dbname}" }
  end

  def test_should_raise_exception_if_dir_cannot_be_created
    # Because that file exists
    FileUtils.touch(@dbname)
    assert_raises FileManagerException do
      FileManager.new(@dbname)
    end
    FileUtils.rm(@dbname)
    # Or because that file is not writable.
    FileUtils.mkdir(@dbname)
    `chmod u-w #{@dbname}`
    assert_raises FileManagerException do
      FileManager.new(@dbname)
    end
  end

  def test_size_should_return_number_of_file_blocks_in_file
    filename = "temp_empty_file_size_test"
    f = FileManager.new(@dbname)
    assert_equal 0, f.size(filename)
    small_filename = "temp_sub_block_size_test"
    File.open("#{@dbname}/#{small_filename}", 'w+') do |small_file|
      small_file << 'test'
    end
    assert_equal 0, f.size(small_filename)
    big_filename = "temp_larger_than_block_size_test"
    big_file = f.send(:get_file, big_filename)
    1026.times do
      big_file << 'x'
    end
    assert_equal 2, f.size(big_filename)
  end

end