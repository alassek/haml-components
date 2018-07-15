require "spec_helper"

RSpec.describe "Component Rendering" do
  before :all do
    Haml::Components.enable!

    Haml::Components.configure do |c|
      c.define(:FooTag) { |options = {}| <<-HTML }
        <foo-tag id="#{options[:id]}">
          Hello, World!
        </foo-tag>
      HTML
    end
  end

  subject { Haml::Engine.new("%FooTag{id: 'bar'}").render }

  it "renders as expected" do
    expect(subject).to include %q{<foo-tag id="bar">}
    expect(subject).to include "Hello, World!"
  end
end
