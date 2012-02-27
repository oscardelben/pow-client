module Pow

  USAGE = "USAGE: pow add|remove|open [arguments]"

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
      else
        puts Pow::USAGE
      end
    end
  end

  class Add
  end

  class Remove
  end

  class Open
  end
end
