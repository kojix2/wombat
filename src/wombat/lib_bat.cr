module Wombat
  {% if flag?(:linux) %}
    {% if env("SHARED") %}
      @[Link("bat_c")]
    {% else %}
      @[Link(ldflags: "#{__DIR__}/../ext/libbat_c.a -lz -lm")]
    {% end %}
  {% elsif flag?(:darwin) %}
    {% if env("SHARED") %}
      @[Link("bat_c")]
    {% else %}
      @[Link(ldflags: "#{__DIR__}/../ext/libbat_c.a -lz -lm")]
    {% end %}
  {% elsif flag?(:windows) %}
    @[Link("OneCore")]
    @[Link("Shell32")]
    @[Link("ntdll")]
    @[Link("ws2_32")]
    @[Link("bcrypt")]
    @[Link("secur32")]
    @[Link("Shlwapi")]
    @[Link("Userenv")]
    @[Link("ucrt")]
    # @[Link("libucrt")]
    @[Link("#{__DIR__}/../ext/bat_c")]
    @[Link(ldflags: "/NODEFAULTLIB:MSVCRT")] # /NODEFAULTLIB:libucrt.lib
  {% end %}
  lib Bat
    # BatInputType enum to specify the type of input
    enum BatInputType
      BatBytes
      BatFile
      BatFiles
    end

    struct BatPrintOptions
      tab_width : LibC::SizeT
      colored_output : Bool
      true_color : Bool
      header : Bool
      line_numbers : Bool
      grid : Bool
      rule : Bool
      show_nonprintable : Bool
      snip : Bool
      wrapping_mode : LibC::SizeT
      use_italics : Bool
      paging_mode : LibC::SizeT
      highlight_line : LibC::SizeT
    end

    fun bat_pretty_print(input : Pointer(UInt8), length : LibC::SizeT, input_type : BatInputType, language : Pointer(UInt8), theme : Pointer(UInt8), options : BatPrintOptions) : Int32
    fun bat_pretty_print_to_string(input : Pointer(UInt8), length : LibC::SizeT, input_type : BatInputType, language : Pointer(UInt8), theme : Pointer(UInt8), options : BatPrintOptions, output : Pointer(Pointer(UInt8)), output_length : Pointer(LibC::SizeT)) : Int32
    fun bat_free_string(input : Pointer(UInt8)) : Nil
    fun bat_c_version : Pointer(UInt8)
  end
end
