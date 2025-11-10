{% if flag?(:darwin) %}
  system(File.expand_path("download_bat_c_static_library.sh", __DIR__))
{% elsif flag?(:linux) %}
  system(File.expand_path("download_bat_c_static_library.sh", __DIR__))
{% elsif flag?(:windows) %}
  system(File.expand_path("download_bat_c_static_library.bat", __DIR__))
{% else %}
  puts "Unsupported platform"
  exit 1
{% end %}
