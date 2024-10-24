source "https://rubygems.org"

gemspec

gem "benchmark-ips"
gem "irb"
gem "minitest"
gem "rake"
gem "rubocop", require: false
gem "rubocop-minitest", require: false
gem "rubocop-rake", require: false
gem "standard", ">= 1.35.1", require: false
gem "standard-performance", require: false

install_if -> { !RUBY_VERSION.start_with?("3.0") } do
  gem "tailwind_merge"
end
