require 'rudbms/server/startup'

class TestStartup < MiniTest::Unit::TestCase

  def setup
    @dbname = 'testdb'
  end

  def teardown
    FileUtils.rm_rf(@dbname) if File.exists?(@dbname)
  end

  def test_main_method_should_return_boolean
    assert_equal(!!Startup.main(@dbname), Startup.main(@dbname),
                 'Startup.main did not return a boolean value')
  end

end
