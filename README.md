# Haml::Components

Haml Components are intended to be an intuitive way to build custom tags in your markup that automatically expand into something else.

This is a proof-of-concept prototype, and _very_ alpha.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'haml-components'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install haml-components

## Usage

Enable components with `Haml::Components.enable!` during your app startup.

Then, define components as a block that returns a string of HTML using whatever method you want.

```ruby
Haml::Components.define :FooTag do |options = {}|
  %Q{<foo-tag>Hello, #{options[:greet]}!</foo-tag>}
end
```

Then, simply reference the tag you defined in your Haml markup. Attributes get passed as options.

```haml
%FooTag{ greet: "World" }
```

```html
<foo-tag>Hello, World!</foo-tag>
```

## TODO

Currently not supported, but needed for MVP:

- [ ] support Haml `id` and `class` syntax
- [ ] support dynamic attributes
- [ ] support child markup with some form of transclusion
- [ ] component definitions should be rendered with the view binding somehow

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alassek/haml-components.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
