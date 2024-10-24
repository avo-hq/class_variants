# Class variants

We ❤️ Tailwind CSS but sometimes it's difficult to manage the state of some elements using conditionals. `class_variants` is a tiny helper that should enable you to create, configure, and apply different variants of elements as classes.

Inspired by [variant-classnames](https://github.com/mattvalleycodes/variant-classnames) ✌️

## Quicklinks

* [DRY up your tailwind CSS using this awesome gem](https://www.youtube.com/watch?v=cFcwNH6x77g)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'class_variants'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install class_variants
```

## Usage

We create an object from the class or helper where we define the configuration using four arguments:

1. The `base` keyword argument with default classes that should be applied to each variant.
1. The `variants` keyword argument where we declare the variants with their option and classes.
1. The `compound_variants` keyword argument where we declare the compound variants with their conditions and classes
1. The `defaults` keyword argument (optional) where we declare the default value for each variant.

## Example

Below we implement the [button component](https://tailwindui.com/components/application-ui/elements/buttons) from Tailwind UI.

```ruby
# Define the variants and defaults
button_classes = ClassVariants.build(
  base: "inline-flex items-center rounded border border-transparent font-medium text-white hover:text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2",
  variants: {
    size: {
      sm: "px-2.5 py-1.5 text-xs",
      md: "px-3 py-2 text-sm",
      lg: "px-4 py-2 text-sm",
      xl: "px-4 py-2 text-base",
    },
    color: {
      indigo: "bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-500",
      red: "bg-red-600 hover:bg-red-700 focus:ring-red-500",
      blue: "bg-blue-600 hover:bg-blue-700 focus:ring-blue-500",
    },
    # A variant whose value is a string will be expanded into a hash that looks
    # like  { true => "classes" }
    block: "w-full justify-center",
    # Unless the key starts with !, in which case it will expand into
    # { false => "classes" }
    "!block": "w-auto",
  },
  defaults: {
    size: :md,
    color: :indigo,
    icon: false
  }
)

# Call it with our desired variants
button_classes.render(color: :blue, size: :sm)
button_classes.render
button_classes.render(color: :red, size: :xl, icon: true)
```

### Compound Variants

```ruby
button_classes = ClassVariants.build(
  base: "inline-flex items-center rounded",
  variants: {
    color: {
      red:  "bg-red-600",
      blue: "bg-blue-600",
    },
    border: "border"
  },
  compound_variants: [
    { color: :red,  border: true, class: "border-red-800"  },
    { color: :blue, border: true, class: "border-blue-800" }
  ]
)

button_classes.render(color: :red) # => "inline-flex items-center rounded bg-red-600"
button_classes.render(color: :red, border: true) # => "inline-flex items-center rounded bg-red-600 border border-red-600"
```

## Use with Rails

```ruby
# Somewhere in your helpers
def button_classes(classes, **args)
  class_variants(
    base: "inline-flex items-center rounded border border-transparent font-medium text-white hover:text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2",
    variants: {
      size: {
        sm: "px-2.5 py-1.5 text-xs",
        md: "px-3 py-2 text-sm",
        lg: "px-4 py-2 text-sm",
        xl: "px-4 py-2 text-base",
      },
      color: {
        indigo: "bg-indigo-600 hover:bg-indigo-700 focus:ring-indigo-500",
        red: "bg-red-600 hover:bg-red-700 focus:ring-red-500",
        blue: "bg-blue-600 hover:bg-blue-700 focus:ring-blue-500",
      },
    },
    defaults: {
      size: :md,
      color: :indigo,
    }
  )
end
```

```erb
<!-- In your views -->
<%= link_to :Avo, "https://avohq.io", class: button_classes.render(color: :blue, size: :sm) %>
<%= link_to :Avo, "https://avohq.io", class: button_classes.render %>
<%= link_to :Avo, "https://avohq.io", class: button_classes.render(color: :red, size: :xl) %>
```

### Output

![](sample.jpg)

## Other packages

 - [`active_storage-blurhash`](https://github.com/avo-hq/active_storage-blurhash) - A plug-n-play [blurhash](https://blurha.sh/) integration for images stored in ActiveStorage
 - [`avo`](https://github.com/avo-hq/avo) - Build Content management systems with Ruby on Rails
 - [`prop_initializer`](https://github.com/avo-hq/prop_initializer) - A flexible tool for defining properties on Ruby classes.
 - [`stimulus-confetti`](https://github.com/avo-hq/stimulus-confetti) - The easiest way to add confetti to your StimulusJS app

## Try Avo ⭐️

If you enjoyed this gem try out [Avo](https://github.com/avo-hq/avo). It helps developers build Internal Tools, Admin Panels, CMSes, CRMs, and any other type of Business Apps 10x faster on top of Ruby on Rails.

[![](./logo-on-white.png)](https://github.com/avo-hq/avo)

## Contributing

1. Fork it `git clone https://github.com/avo-hq/class_variants`
1. Create your feature branch `git checkout -b my-new-feature`
1. Commit your changes `git commit -am 'Add some feature'`
1. Push to the branch `git push origin my-new-feature`
1. Create new Pull Request

## License
This package is available as open source under the terms of the MIT License.

## Cutting a release

```bash
# Build
gem build class_variants.gemspec -o latest.gem
# Publish
gem push --host https://rubygems.org/ ./latest.gem
# Cut a tag
git tag v0.0.6 -a -m "Version 0.0.6"
# Push tag to repo
git push --follow-tags
# Go to the repo and generate release from tag
```
