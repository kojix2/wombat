# wombat

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     bat:
       github: kojix2/wombat
   ```

2. Run `shards install`

## Usage

```crystal
require "wombat"

puts Wombat.pretty_string(%{puts "hello world"})
```

## Development

Maintainability is important. 

## Contributing

1. Fork it (<https://github.com/your-github-user/bat/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
