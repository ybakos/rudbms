# file/file_manager.rb
# Yong Joseph Bakos
# Translated from simpledb/file/FileManager.java
#
# The Rudbms file manager.
# The database system stores its data as files within a specified directory.
# The file manager provides methods for reading the contents of a file block
# to a Page, writing the contents of a Page to a file block,
# and appending the contents of a Page to the end of a file.
# These methods are called exclusively by the class <tt>Page</tt>.
# This class also contains two public methods:
# <tt>isNew()</tt> is called during system initialization by <tt>SimpleDB#init</tt>.
# <tt>size(String)</tt> is called by the log manager and transaction manager to
# determine the end of the file (Sciore, 2009).
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
    create_database_directory(dbpath)
    remove_any_leftover_temp_tables(dbpath)
  rescue Errno::EEXIST
    raise FileManagerException.new("Could not create directory #{dbpath}")
  rescue Errno::EACCES
    raise FileManagerException.new("No write permissions on directory #{dbpath}")
  end
  
  # Returns the number of blocks in the specified file.
  # <tt>filename</tt>: the name of the file
  def size(filename)
    begin
      f = get_file(filename)
      return f.size / Page::BLOCK_SIZE
    rescue
      raise FileManagerException.new("Could not read file #{filename}")
    end
  end

  private

    # Returns the File instance for the specified filename.
    # The File instance is stored in a map keyed on the filename.
    # If the file is not open, then it is opened and the File instance
    # is added to the map.
    # <tt>filename</tt>: the specified filename
    def get_file(filename)
      f = @open_files[filename] || new_file(filename)
    end

    # Adds a file to the FileManager's internal hash table.
    def new_file(filename)
      @open_files[filename] = File.new("#{@db_directory.path}/#{filename}", 'w+')
    end

    # Deletes temp files in directory <tt>dbpath</tt>.
    def remove_any_leftover_temp_tables(dbpath)
      Dir.foreach("#{dbpath}") do |f|
        FileUtils.rm("#{dbpath}/#{f}") if f.start_with? TEMP_FILE_PREFIX
      end  
    end

    def create_database_directory(dbpath)
      if File.exists?(dbpath) && File.directory?(dbpath)
        @is_new = false
      else
        Dir.mkdir(dbpath)
        @is_new = true
      end
      raise Errno::EACCES unless File.writable? dbpath
      @db_directory = File.new(dbpath)
    end

end