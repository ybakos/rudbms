# The SimpleDB file manager.
# The database system stores its data as files within a specified directory.
# The file manager provides methods for reading the contents of a file block
# to a Java byte buffer, writing the contents of a byte buffer to a file block,
# and appending the contents of a byte buffer to the end of a file.
# These methods are called exclusively by the class <tt>Page</tt>, and are
# thus package-private.
# The class also contains two public methods:
# <tt>isNew()</tt> is called during system initialization by <tt>SimpleDB#init</tt>.
# <tt>size(String)</tt> is called by the log manager and transaction manager to
# determine the end of the file.
# (Edward Sciore)
class FileManagerException < Exception; end

class FileManager

  TEMP_FILE_PREFIX = "temp"

  attr_reader :is_new; alias_method :is_new?, :is_new

  # Creates a file manager for the specified database.
  # The database will be stored in a folder of that name in the user's home directory.
  # If the folder does not exist, then a folder containing an empty database
  # is created automatically.
  # Files for all temporary tables (i.e. tables beginning with "temp") are deleted.
  # <tt>dbname</tt>: the name of the directory that holds the database.
  def initialize(dbname)
    @open_files = Hash.new
    dbpath = "#{Dir.pwd}/#{dbname}"
    # TODO: Be sure that the CLI will prompt the user if a dir exists.
    if File.exists?(dbpath) && File.directory?(dbpath)
      @is_new = false
    else
      Dir.mkdir(dbpath)
      @is_new = true
    end
    unless File.writable? dbpath
      raise FileManagerException.new("No write permissions on directory #{dbpath}")
    end
    @db_directory = File.new(dbpath)
    # remove any leftover temporary tables
    Dir.foreach("#{dbpath}") do |f|
      FileUtils.rm("#{dbpath}/#{f}") if f.start_with? TEMP_FILE_PREFIX
    end
  rescue Errno::EEXIST
    raise FileManagerException.new("Could not create directory #{dbpath}")
  rescue Errno::EACCES
    raise FileManagerException.new("No write permissions on directory #{dbpath}")
  end

  #TODO

end