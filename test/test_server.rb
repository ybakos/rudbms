require 'rudbms/server/server'
require 'rudbms/file/file_manager'
require 'rudbms/log/log_manager'
require 'rudbms/buffer/buffer_manager'
require 'rudbms/metadata/metadata_manager'

class TestServer < MiniTest::Unit::TestCase

  def setup
    @dbname = 'testdb'
  end

  def teardown
    FileUtils.rm_rf(@dbname) if File.exists?(@dbname)
  end

  def test_server_class_should_have_class_member_LOG_FILE
    refute_nil Server::LOG_FILE
  end

  def test_server_class_should_have_class_member_BUFFER_SIZE
    refute_nil Server::BUFFER_SIZE
  end

  def test_init_should_instantiate_managers
    Server.init(@dbname)
    assert_instance_of FileManager, Server.file_manager, 'Could not obtain FileManager instance from Server'
    assert_instance_of LogManager, Server.log_manager, 'Could not obtain LogManager instance from Server'
    assert_instance_of BufferManager, Server.buffer_manager, 'Could not obtain BufferManager instance from Server'
    assert_instance_of MetadataManager, Server.metadata_manager, 'Could not obtain MetadataManager instance from Server'
  end

  def test_should_be_able_to_obtain_planner
    assert_instance_of Planner, Server.planner, 'Could not obtain Planner instance from Server'
  end

end