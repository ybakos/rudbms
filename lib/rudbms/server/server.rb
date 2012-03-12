require 'rudbms/file/file_manager'

class Server

  def self.init(dbname)
     init_file_log_and_buffer_managers(dbname)
    true
  end

  def self.init_file_log_and_buffer_managers(dirname)
    @@fm = FileManager.new(dirname)
  end

end
