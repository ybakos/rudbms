# A simple whitebox test for the main executable.
# See ./features for further tests.

load 'bin/rudbms'

class TestRudbms < MiniTest::Unit::TestCase

  def test_executable_has_start_command
    assert(Rudbms::Rudbms.new.respond_to?(:start), 'Rudbms executable missing start method')
  end

end