# The class that provides system-wide static global values.
# These values must be initialized by the method <tt>#init</tt> before use.
# The methods <tt>#initFileMgr</tt>, <tt>initFileAndlog_managergr</tt>,
# <tt>initFileLogAndBufferMgr</tt>, and <tt>initMetadataMgr</tt>
# provide limited initialization, and are useful for debugging purposes.
# (Edward Sciore)
require 'rudbms/file/file_manager'
require 'rudbms/log/log_manager'
require 'rudbms/buffer/buffer_manager'
require 'rudbms/metadata/metadata_manager'
require 'rudbms/tx/transaction'
require 'rudbms/planner/planner'
require 'rudbms/planner/basic_query_planner'
require 'rudbms/planner/basic_update_planner'

class Server

  class << self
    attr_accessor :file_manager
    attr_accessor :log_manager
    attr_accessor :buffer_manager
    attr_accessor :metadata_manager
  end

  BUFFER_SIZE = 8
  LOG_FILE = "rudbms.log"
   
  # Initializes the system. This method is called during system startup.
  def self.init(dbname)
    init_file_log_and_buffer_managers(dbname)
    tx = Transaction.new
    unless @file_manager.is_new?
      puts "Recovering existing database"
      tx.recover
    end
    init_metadata_manager(@file_manager.is_new?, tx);
    tx.commit
    true
  end

  def self.init_file_log_and_buffer_managers(dirname)
    init_file_and_log_managers(dirname)
    init_buffer_manager
  end

  def self.init_file_and_log_managers(dirname)
    init_file_manager(dirname)
    init_log_manager
  end

  def self.init_file_manager(dirname)
    @file_manager = FileManager.new(dirname)
  end

  def self.init_log_manager
    @log_manager = LogManager.new(LOG_FILE)
  end

  def self.init_buffer_manager
    @buffer_manager = BufferManager.new(BUFFER_SIZE)
  end

  def self.init_metadata_manager(is_new, tx)
    @metadata_manager = MetadataManager.new(is_new, tx)
  end

  # Creates a planner for SQL commands.
  # To change how the planner works, modify this method.
  def self.planner
    Planner.new(BasicQueryPlanner.new, BasicUpdatePlanner.new)
  end

end
