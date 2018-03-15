require "logger"

module PLSQL #:nodoc:
  module Logging #:nodoc:
    @loggers = {}

    def logger
      @logger ||= Logging.logger_for(self.class.name)
    end

    class << self
      attr_accessor :destination
      attr_accessor :log_level

      def logger_for(classname)
        @loggers[classname] ||= configure_logger_for(classname)
      end

      def configure_logger_for(classname)
        logger = Logger.new(@destination || STDOUT)
        logger.progname = classname
        logger.level = @log_level || Logger::ERROR
        logger
      end
    end
  end
end
