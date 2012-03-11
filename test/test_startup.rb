require 'rudbms/server/startup'

class TestStartup < MiniTest::Unit::TestCase

    def test_main_method_should_return_boolean
      assert_equal(!!Startup.main([]), Startup.main([]),
                   'Startup.main did not return a boolean value')
    end

end
