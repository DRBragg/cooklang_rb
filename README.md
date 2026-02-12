# CooklangRb

[![Gem Version](https://badge.fury.io/rb/cooklang_rb.svg)](https://badge.fury.io/rb/cooklang_rb)
[![Ruby](https://github.com/DRBragg/cooklang_rb/actions/workflows/main.yml/badge.svg)](https://github.com/DRBragg/cooklang_rb/actions/workflows/main.yml)

A Ruby parser for [Cooklang](https://cooklang.org/) — compatible with the [v7 spec](https://cooklang.org/docs/spec/).

If you're unfamiliar with [Cooklang](https://cooklang.org/), please visit [https://cooklang.org/](https://cooklang.org/) to learn more about using Cooklang.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cooklang_rb'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cooklang_rb

## Usage

```ruby
source = <<~COOK
---
source: https://www.dinneratthezoo.com/wprm_print/6796
time: 6 minutes
servings: 2
---

Place the @apple juice{1.5%cups}, @banana{one sliced}, @frozen mixed berries{1.5%cups} and @vanilla greek yogurt{3/4%cup} in a #blender{}; blend until smooth.

Taste and add @honey{} if desired. Pour into two glasses and garnish with fresh berries and mint sprigs if desired.
COOK

recipe = CooklangRb::Recipe.new(source)

pp recipe.data
# {
#   "metadata" => {...},
#   "steps" => [
#     [...],
#     [...]
#   ]
# }

pp recipe.metadata
# {
#   "source" => "https://www.dinneratthezoo.com/wprm_print/6796",
#   "time" => "6 minutes",
#   "servings" => "2"
# }

pp recipe.steps
# [
#   [
#     {"type" => "text", "value" => "Place the "},
#     {"type" => "ingredient", "name" => "apple juice", "quantity" => 1.5, "units" => "cups"},
#     {"type" => "text", "value" => ", "},
#     {"type" => "ingredient", "name" => "banana", "quantity" => "one sliced", "units" => ""},
#     {"type" => "text", "value" => ", "},
#     {"type" => "ingredient", "name" => "frozen mixed berries", "quantity" => 1.5, "units" => "cups"},
#     {"type" => "text", "value" => " and "},
#     {"type" => "ingredient", "name" => "vanilla greek yogurt", "quantity" => 0.75, "units" => "cup"},
#     {"type" => "text", "value" => " in a "},
#     {"type" => "cookware", "name" => "blender", "quantity" => 1, "units" => ""},
#     {"type" => "text", "value" => "; blend until smooth."}
#   ],
#   [
#     {"type" => "text", "value" => "Taste and add "},
#     {"type" => "ingredient", "name" => "honey", "quantity" => "some", "units" => ""},
#     {"type" => "text", "value" => " if desired. Pour into two glasses and garnish with fresh berries and mint sprigs if desired."}
#   ]
# ]
```

### Metadata

Metadata uses YAML front matter delimited by `---`:

```ruby
source = <<~COOK
---
title: Spaghetti Carbonara
tags:
  - pasta
  - quick
---

Boil @pasta{500%g} in a #pot{}.
COOK

recipe = CooklangRb::Recipe.new(source)
recipe.metadata
# => {"title" => "Spaghetti Carbonara", "tags" => ["pasta", "quick"]}
```

### Comments

```ruby
source = <<~COOK
-- This is a line comment
@eggs{2} -- inline comment
Slowly add @milk{4%cup} [- block comment -], keep mixing
COOK
```

Please visit the [Cooklang Docs](https://cooklang.org/docs) for more information about the Cooklang specification.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drbragg/cooklang_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/drbragg/cooklang_rb/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CooklangRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/drbragg/cooklang_rb/blob/main/CODE_OF_CONDUCT.md).
