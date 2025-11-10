require "./spec_helper"

describe Wombat do
  it "has a version number" do
    Wombat::VERSION.should be_a String
  end

  it "returns bat_c version" do
    version = Wombat.bat_c_version
    version.should be_a String
    version.should_not be_empty
  end

  describe ".pretty_string" do
    it "highlights Crystal code" do
      code = %{puts "Hello, World!"}
      result = Wombat.pretty_string(code, language: "Crystal")
      result.should be_a String
      result.should_not be_empty
      result.should contain("Hello, World!")
    end

    it "handles empty string" do
      result = Wombat.pretty_string("")
      result.should be_a String
    end

    it "works without specifying language" do
      code = %{def hello; end}
      result = Wombat.pretty_string(code)
      result.should be_a String
      result.should_not be_empty
    end
  end

  describe ".pretty_print" do
    it "prints without error" do
      code = %{fn main() { println!("Hello"); }}
      # Should not raise an exception
      Wombat.pretty_print(code, language: "Rust", paging_mode: 2)
    end
  end

  describe ".pretty_print_file" do
    it "prints a file without error" do
      # Create a temporary file
      File.write("/tmp/test_wombat.cr", %{puts "test"})

      # Use paging_mode: 2 to avoid interactive pager
      Wombat.pretty_print_file("/tmp/test_wombat.cr", paging_mode: 2)

      # Clean up
      File.delete("/tmp/test_wombat.cr")
    end

    it "handles non-existent file" do
      # The underlying C library may handle this differently
      # For now, we just verify it doesn't crash
      begin
        Wombat.pretty_print_file("/nonexistent/file.cr", paging_mode: 2)
      rescue ex : Wombat::Error
        ex.message.to_s.should contain("Failed to pretty print file")
      end
    end

    it "accepts Path objects" do
      File.write("/tmp/test_wombat_path.cr", %{puts "test"})

      Wombat.pretty_print_file(Path.new("/tmp/test_wombat_path.cr"), paging_mode: 2)

      File.delete("/tmp/test_wombat_path.cr")
    end
  end
end
