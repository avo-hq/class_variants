# frozen_string_literal: true
require "benchmark/ips"

module ClassVariants
end

require_relative "lib/class_variants/instance"


Benchmark.ips do |x|
  button_classes = ClassVariants::Instance.new(
    "rounded border-2 focus:ring-blue-500",
    variants: {
      size: {
        sm: "text-xs px-1.5 py-1",
        base: "text-sm px-2 py-1.5",
        lg: "text-base px-3 py-2",
      },
      color: {
        white: "text-white bg-transparent border-white",
        blue: "text-white bg-blue-500 border-blue-700 hover:bg-blue-600",
        red: "text-white bg-red-500 border-red-700 hover:bg-red-600",
      },
      block: "justify-center w-full",
      "!block": "justify-between",
    },
    defaults: {
      size: :base,
      color: :white,
      block: false,
    }
  )

  x.report("rendering only defaults") do
    button_classes.render
  end

  x.report("rendering with overrides") do
    button_classes.render(size: :sm, color: :red, block: true)
  end
end
