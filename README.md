# wombat

Wombat is a Crystal binding for [bat](https://github.com/sharkdp/bat) syntax highlighting library.

- [bat](https://github.com/sharkdp/bat) - A cat(1) clone with wings.
- [bat-c](https://github.com/kojix2/bat-c) - A C wrapper for bat.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     bat:
       github: kojix2/wombat
   ```

2. Run `shards install`
3. Postinstall script will download the static library to `src/ext' directory.

## Usage

- [API Documentation](https://kojix2.github.io/wombat/)

### Example

If you want to run the example, you need to download the static library first.

```
git clone https://github.com/kojix2/wombat
shards install
crystal run scripts/download_bat_c_static_library.cr
```

```crystal
require "wombat"

puts Wombat.pretty_string(%{puts "hello world"})
```

## Development

- Sustainable development is important.

## Contributing

- Your contributions are always welcome!