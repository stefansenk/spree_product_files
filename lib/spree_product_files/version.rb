module SpreeProductFiles
  module_function

  # Returns the version of the currently loaded SpreeProductFiles as a
  # <tt>Gem::Version</tt>.
  def version
    Gem::Version.new VERSION::STRING
  end

  module VERSION
    MAJOR = 3
    MINOR = 4
    TINY  = 0
    # PRE   = 'alpha'.freeze
    PRE   = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')
  end
end
