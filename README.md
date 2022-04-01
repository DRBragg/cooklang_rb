# CooklangRb

[![Gem Version](https://badge.fury.io/rb/cooklang_rb.svg)](https://badge.fury.io/rb/cooklang_rb)
[![Ruby](https://github.com/DRBragg/cooklang_rb/actions/workflows/main.yml/badge.svg)](https://github.com/DRBragg/cooklang_rb/actions/workflows/main.yml)

A Ruby parser for [Cooklang](https://cooklang.org/).

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
source = <<EOF
>> source: https://www.dinneratthezoo.com/wprm_print/6796
>> total time: 6 minutes
>> servings: 2

Place the @apple juice{1,5%cups}, @banana{one sliced}, @frozen mixed berries{1,5%cups} and @vanilla greek yogurt{3/4%cup} in a #blender{}; blend until smooth. If the smoothie seems too thick, add a little more liquid (1/4 cup).

Taste and add @honey{} if desired. Pour into two glasses and garnish with fresh berries and mint sprigs if desired.
EOF

recipe = CooklangRb::Recipe.new(source)

pp recipe.data
# {
#  "metadata"=> {...},
#  "steps"=> [
#    [...],
#    [...]
#  ]
# }

pp recipe.metadata
# {
#   "source"=>"https://www.dinneratthezoo.com/wprm_print/6796",
#   "total time"=>"6 minutes",
#   "servings"=>"2"
# }

pp recipe.steps
# [
#   [
#     {
#       "type"=>"text",
#       "value"=>"Place the "
#     },
#     {
#       "type"=>"ingredient",
#       "name"=>"apple juice",
#       "quantity"=>"1,5",
#       "units"=>"cups"
#     },
#     {
#       "type"=>"text",
#       "value"=>", "
#     },
#     ...
#   ],
#   [
#     {
#       "type"=>"text",
#       "value"=>"Taste and add "
#     },
#     ...
#   ]
# ]

```

Please visit the [Cooklang Docs](https://cooklang.org/docs) for more information about the Cooklang specification.  Including parser impementations in other languages

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/drbragg/cooklang_rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/drbragg/cooklang_rb/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CooklangRb project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/drbragg/cooklang_rb/blob/master/CODE_OF_CONDUCT.md).
