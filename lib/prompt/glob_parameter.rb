module Prompt
  class GlobParameter < Parameter

    def initialize(name, desc, &block)
      super(name, desc, nil)
      @proc = block
    end

    def regex
      "(?<#{name}>.+)"
    end

  end
end