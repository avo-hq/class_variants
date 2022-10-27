# Class variants

We ❤️ Tailwind CSS but sometimes it's difficult to manage the state of some elements using conditionals. `class_variants` is a tiny helper that should enable you to create, configure, and apply different variants of elements as classes.

## Installation

Add this line to your application's Gemfile:

```
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

We create an object from the class or helper where we define the configuration using three arguments:

1. The default classes that should be applied to each variant
1. The `variants` keyword argument where we declare the variants with their option and classes
1. The `defaults` keyword argument (optional) where we declare the default value for each variant.

## Example

Below we implement the [button component](https://tailwindui.com/components/application-ui/elements/buttons) from Tailwind UI.

```ruby
# Define the variants and defaults
button_classes = ClassVariants.new(
  "inline-flex items-center rounded border border-transparent font-medium text-white hover:text-white shadow-sm focus:outline-none focus:ring-2 focus:ring-offset-2",
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

# Call it with our desired variants
button_classes.render(color: :blue, size: :sm)
button_classes.render
button_classes.render(color: :red, size: :xl)
```

## Use with Rails

```erb
<%= link_to :Avo, "https://avohq.io", class: button_classes.render(color: :blue, size: :sm) %>
<%= link_to :Avo, "https://avohq.io", class: button_classes.render %>
<%= link_to :Avo, "https://avohq.io", class: button_classes.render(color: :red, size: :xl) %>
```

### Output

![](sample.jpg)