module Pow
  class Parser
    def initialize args
      command = args.delete_at 0
      case command
      when 'add'
        Add.new *args
      when 'remove'
        Remove.new *args
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
