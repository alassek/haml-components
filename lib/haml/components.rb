require "haml"
require "haml/components/version"
require "haml/component/renderer"

module Haml
  module Components
    module Definitions
      extend self
    end

    Error               = Class.new(StandardError)
    AlreadyDefinedError = Class.new(Error)

    class << self
      def configure
        yield self
      end

      def tag_names
        @tag_names ||= Set.new
      end

      def define(name, &block)
        if tag_names.add?(name.to_sym)
          Definitions.module_eval do
            define_method name, &block
          end
        else
          raise AlreadyDefinedError, name.to_s
        end
      end

      def defined?(tag_name)
        tag_names.include? tag_name.to_sym
      end

      def render(tag_name, attributes = {})
        Definitions.send(tag_name, attributes).to_s
      end

      def enabled?
        Haml::TempleEngine.chain.map(&:first).include?(:ComponentRenderer)
      end

      def enable!
        return if enabled?

        options = Options.wrap(TempleEngine.options)

        Haml::TempleEngine.before :Compiler, :ComponentRenderer, Component::Renderer.new(options)
      end
    end
  end
end
