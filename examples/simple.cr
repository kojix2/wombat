require "../src/wombat"

# Output the file content with syntax highlighting by calling the rust function
Wombat.pretty_print(path: Path[__FILE__])

# Output the highlighted string of the input by calling the rust function
Wombat.pretty_print(input: %{fn main() { println!("Hello, world!"); }}, language: "Rust")

# Get the highlighted string of the input
puts Wombat.pretty_string(%{puts "Hello, World!"}, language: "Crystal", theme: "TwoDark")
