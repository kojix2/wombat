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
      # Create a temporary file using tempfile
      File.tempfile("test_wombat", ".cr") do |file|
        file.print %{puts "test"}
        file.flush

        # Use paging_mode: 2 to avoid interactive pager
        Wombat.pretty_print_file(file.path, paging_mode: 2)
      end
    end

    it "handles non-existent file" do
      # The underlying C library may handle this differently
      # For now, we just verify it doesn't crash
      non_existent = File.join(Dir.tempdir, "nonexistent_#{Random.rand(10000)}.cr")
      begin
        Wombat.pretty_print_file(non_existent, paging_mode: 2)
      rescue ex : Wombat::Error
        ex.message.to_s.should contain("Failed to pretty print file")
      end
    end

    it "accepts Path objects" do
      File.tempfile("test_wombat_path", ".cr") do |file|
        file.print %{puts "test"}
        file.flush

        Wombat.pretty_print_file(Path.new(file.path), paging_mode: 2)
      end
    end
  end
end
