require 'rudbms/server/server'

class Startup

  def self.main(dbname)
    Server.init(dbname)
  end

end
