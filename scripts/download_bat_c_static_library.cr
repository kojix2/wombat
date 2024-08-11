require "compress/zip"
require "crest"

DEST_DIR = Path["#{__DIR__}/../src/ext"]

def url_for_libui_ng_nightly(file_name)
  "https://github.com/kojix2/bat-c/releases/latest/download/#{file_name}"
end

def download_libui_ng_nightly(lib_path, file_name)
  url = url_for_libui_ng_nightly(file_name)
  download_from_url(lib_path, file_name, url)
end

def download_from_url(lib_path, file_name, url)
  puts "Downloading #{lib_path} from #{url}"

  Crest.get(url) do |response|
    File.open(file_name, "wb") do |file|
      IO.copy(response.body_io, file)
    end
  end

  if file_name.ends_with?(".zip")
    Compress::Zip::File.open(file_name) do |zip_file|
      zip_file.entries.each do |entry|
        if lib_path.includes?(entry.filename)
          print "Extracting #{entry.filename} from #{file_name}..."
          entry.open do |io|
            File.open(DEST_DIR / File.basename(entry.filename), "wb") do |file|
              IO.copy(io, file)
            end
          end
          puts "done"
        end
      end
    end
  end
ensure
  File.delete(file_name) if File.exists?(file_name)
end

{% if flag?(:darwin) %}
  download_libui_ng_nightly(
    ["libbat_c.a"],
    "bat_c_macos.zip"
  )
{% elsif flag?(:linux) %}
  download_libui_ng_nightly(
    ["libbat_c.a"],
    "bat_c_ubuntu.zip"
  )
{% elsif flag?(:windows) %}
  download_libui_ng_nightly(
    ["bat_c.lib"],
    "bat_c_windows.zip"
  )
  require "file_utils"
  FileUtils.mv("libui.a", "libui.lib")
{% end %}
