require "./wombat/version"
require "./wombat/lib_bat"

module Wombat
  def self.bat_c_version : String
    String.new(Wombat::Bat.bat_c_version)
  end

  def self.pretty_print(path : (String | Path), language : String? = nil, theme : String? = nil,
                        tab_width : Int = 4, colored_output : Bool = true, true_color : Bool = true,
                        header : Bool = true, line_numbers : Bool = true, grid : Bool = true,
                        rule : Bool = true, show_nonprintable : Bool = false, snip : Bool = true,
                        wrapping_mode : Int = 1, use_italics : Bool = true, paging_mode : Int = 1,
                        highlight_line : Int = 1)
    result = Wombat::Bat.bat_pretty_print(
      path.to_s,
      path.to_s.size,
      Wombat::Bat::BatInputType::BatFile,
      language,
      theme,
      Wombat::Bat::BatPrintOptions.new(
        tab_width: tab_width,
        colored_output: colored_output,
        true_color: true_color,
        header: header,
        line_numbers: line_numbers,
        grid: grid,
        rule: rule,
        show_nonprintable: show_nonprintable,
        snip: snip,
        wrapping_mode: wrapping_mode,
        use_italics: use_italics,
        paging_mode: paging_mode,
        highlight_line: highlight_line
      )
    )
    if result != 0
      raise "[wombat] Error: failed to pretty print file : #{path}"
    end
  end

  def self.pretty_print(input : String, language : String? = nil, theme : String? = nil,
                        tab_width : Int = 4, colored_output : Bool = true, true_color : Bool = true,
                        header : Bool = true, line_numbers : Bool = true, grid : Bool = true,
                        rule : Bool = true, show_nonprintable : Bool = false, snip : Bool = true,
                        wrapping_mode : Int = 1, use_italics : Bool = true, paging_mode : Int = 1,
                        highlight_line : Int = 1)
    result = Wombat::Bat.bat_pretty_print(
      input,
      input.size,
      Wombat::Bat::BatInputType::BatBytes,
      language,
      theme,
      Wombat::Bat::BatPrintOptions.new(
        tab_width: tab_width,
        colored_output: colored_output,
        true_color: true_color,
        header: header,
        line_numbers: line_numbers,
        grid: grid,
        rule: rule,
        show_nonprintable: show_nonprintable,
        snip: snip,
        wrapping_mode: wrapping_mode,
        use_italics: use_italics,
        paging_mode: paging_mode,
        highlight_line: highlight_line
      )
    )
    if result != 0
      raise "[wombat] Error: failed to pretty print input"
    end
  end

  def self.pretty_string(input : String, language : String? = nil, theme : String? = nil,
                         tab_width : Int = 4, colored_output : Bool = true, true_color : Bool = true,
                         header : Bool = false, line_numbers : Bool = true, grid : Bool = true,
                         rule : Bool = true, show_nonprintable : Bool = false, snip : Bool = true,
                         wrapping_mode : Int = 1, use_italics : Bool = true, paging_mode : Int = 2,
                         highlight_line : Int = -1) : String
    len_ptr = Pointer(LibC::SizeT).malloc
    output_ptr = Pointer(Pointer(UInt8)).malloc
    result = Wombat::Bat.bat_pretty_print_to_string(
      input,
      input.size,
      Wombat::Bat::BatInputType::BatBytes,
      language,
      theme,
      Wombat::Bat::BatPrintOptions.new(
        tab_width: tab_width,
        colored_output: colored_output,
        true_color: true_color,
        header: header,
        line_numbers: line_numbers,
        grid: grid,
        rule: rule,
        show_nonprintable: show_nonprintable,
        snip: snip,
        wrapping_mode: wrapping_mode,
        use_italics: use_italics,
        paging_mode: paging_mode,
        highlight_line: highlight_line
      ),
      output_ptr,
      len_ptr
    )
    if result != 0
      raise "[wombat] Error: failed to pretty print input"
    end

    # Crystal copy the string from the pointer
    str = String.new(output_ptr.value, len_ptr.value)

    # So we can free the string allocated in Rust
    Wombat::Bat.bat_free_string(output_ptr.value)
    str
  end
end
