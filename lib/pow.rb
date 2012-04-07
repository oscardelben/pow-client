module Pow

  USAGE = "USAGE: pow add|remove|open|restart [arguments]"
  POW_DIR = "~/.pow/"
  APPNAME = `pwd`.chomp.split('/').last

  class Parser
    def initialize args
      command = args.delete_at 0
      case command
      when 'add'
        Add.new *args
      when 'remove'
        Remove.new *args
      when 'open'
        Open.new *args
      when 'restart'
        Restart.new *args
      else
        puts Pow::USAGE
      end
    end
  end

  class Add
    def initialize path=nil, appname=nil
      Runner.run "ln -s #{extract_dir(path)} #{Pow::POW_DIR}#{appname}"
    end

    private

    def extract_dir path
      if !path or path == '.'
        `pwd`.chomp
      else
        path
      end
    end
  end

  class Remove
    def initialize appname=APPNAME
      Runner.run "rm #{Pow::POW_DIR}#{appname}"
    end
  end

  class Open
    def initialize appname=APPNAME
      Runner.run "open http://#{appname}.dev"
    end
  end

  class Restart
    def initialize
      Runner.run "touch tmp/restart.txt"
    end
  end

  ## Wrapper around system for easy testing
  class Runner
    class << self
      def run command
        system command
      end
    end
  end

end
