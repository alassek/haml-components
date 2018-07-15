require "pry"

module Haml
  module Component
    class Renderer
      attr_reader :options

      def initialize(options)
        @options = Options.wrap(options)
      end

      def call(node)
        munge(node)
      end

      private

      def munge(node)
        return render(node) if is_component?(node)
        return node unless node.children.any?
        node.children.map! { |child| munge(child) }
        node
      end

      # TODO: figure out how to support evaling dynamic values
      def attributes(node)
        attributes = node.value[:attributes]
        dynamic    = node.value[:dynamic_attributes]

        if dynamic.old
          attributes.merge! eval(dynamic.old)
        end

        attributes
      end

      def is_component?(node)
        return false unless node.type == :tag
        Haml::Components.defined? node.value[:name]
      end

      # TODO: convert attributes and dynamic_attributes to component options
      def render(node)
        node.type  = :plain
        node.value = {
          text: Haml::Components.render(node.value[:name], attributes(node))
        }

        node
      end
    end
  end
end
