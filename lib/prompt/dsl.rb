require 'prompt/variable'
require 'prompt/proc_variable'
require 'prompt/glob_variable'

module Prompt
  module DSL

    def self.extended(base)
      name = if base.respond_to? :name
        base.name
      else
        "Commands"
      end
      Prompt.application.use_command_group(name)
    end

    def desc desc
      Prompt.application.use_command_group(desc)
    end

    def command(name, desc = nil, &block)
      Prompt.application.define_command(name, desc, @variables || {}, &block)
    end

    def variable(name, desc, values = nil)
      @variables = [] unless defined? @variables
      raise "variable :#{name} is already defined" if @variables.find {|v| v.name == name}
      @variables << Variable.new(name, desc, values)
    end

    def dynamic_variable(name, desc, &block)
      @variables = [] unless defined? @variables
      raise "variable :#{name} is already defined" if @variables.find {|v| v.name == name}
      @variables << ProcVariable.new(name, desc, &block)
    end

  end
end
