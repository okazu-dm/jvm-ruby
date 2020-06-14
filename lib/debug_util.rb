require 'logger'
require 'pp'

LOGGER = Logger.new($stderr)
LOGGER.level = Logger::DEBUG

def debug(msg)
  LOGGER.debug("[DEBUG] #{msg}")
end

def ppdebug(data)
  debug(data.pretty_inspect)
end
