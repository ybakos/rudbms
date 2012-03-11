require 'rudbms/server/server'

class Startup

  def self.main(args)
    Server.init(args[0]);
  end

end
