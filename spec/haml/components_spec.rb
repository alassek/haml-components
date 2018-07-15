require "spec_helper"

RSpec.describe Haml::Components do
  it "has a version number" do
    expect(Haml::Components::VERSION).not_to be nil
  end

  def def_component(name)
    described_class.define(name) { "<#{name}></#{name}>" }
  end

  it "accepts component definitions" do
    expect { def_component(:Foo) }.to_not raise_error
  end

  it "stores definitions in a module" do
    expect { def_component(:Bar) }.to change(described_class::Definitions, :public_instance_methods)
  end

  describe "::tag_names" do
    it "contains a Set of all defined components" do
      expect { def_component(:Baz) }.to change { described_class.tag_names.include?(:Baz) }.from(false).to(true)
    end
  end

  describe "::enable!" do
    def componentized?
      Haml::TempleEngine.chain.map(&:first).include?(:ComponentRenderer)
    end

    it "adds Haml::Component::Renderer into the Temple chain" do
      expect { described_class.enable! }.to change { componentized? }.from(false).to(true)
    end

    it "doesn't add itself more than once" do
      described_class.enable!
      described_class.enable!

      expect(Haml::TempleEngine.chain.count {|c| c.first == :ComponentRenderer }).to eq 1
    end
  end
end
