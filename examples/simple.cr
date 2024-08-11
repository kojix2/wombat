require "../src/wombat"

Wombat.pretty_print(Path[__FILE__])

puts Wombat.pretty_string(%{puts "Hello, World!"}, language: "Crystal", theme: "TwoDark")

puts Wombat.bat_c_version
