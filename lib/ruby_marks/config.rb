#encoding: utf-8
module RubyMarks

  class Config

    attr_accessor :clock_marks_scan_x, :expected_clocks_count, :intensity_percentual, :recognition_colors,
                  :default_marks_options, :default_distance_between_marks, 
                  :clock_width, :clock_height, :threshold_level, :clock_mark_size_tolerance,
                  :default_mark_width, :default_mark_height
    
    def initialize(recognizer)
      @recognizer = recognizer
      @threshold_level = RubyMarks.threshold_level
      
      @intensity_percentual = RubyMarks.intensity_percentual
      @recognition_colors   = RubyMarks.recognition_colors

      @expected_clocks_count = RubyMarks.expected_clocks_count
      @clock_marks_scan_x = RubyMarks.clock_marks_scan_x
      @clock_width  = RubyMarks.clock_width
      @clock_height = RubyMarks.clock_height
      @clock_mark_size_tolerance = RubyMarks.clock_mark_size_tolerance
      
      @default_mark_width  = RubyMarks.default_mark_width
      @default_mark_height = RubyMarks.default_mark_height
      @default_marks_options = RubyMarks.default_marks_options
      @default_distance_between_marks = RubyMarks.default_distance_between_marks
    end

    def calculated_threshold_level
      Magick::QuantumRange * (@threshold_level.to_f / 100)
    end

    def clock_width_with_down_tolerance
      @clock_width - @clock_mark_size_tolerance
    end

    def clock_width_with_up_tolerance
      @clock_width + @clock_mark_size_tolerance
    end

    def clock_height_with_down_tolerance
      @clock_height - @clock_mark_size_tolerance
    end

    def clock_height_with_up_tolerance
      @clock_height + @clock_mark_size_tolerance
    end

    def clock_width_tolerance_range
      clock_width_with_down_tolerance..clock_width_with_up_tolerance
    end

    def clock_height_tolerance_range
      clock_height_with_down_tolerance..clock_height_with_up_tolerance
    end

    def define_group(group_label, &block)
      group = RubyMarks::Group.new(group_label, @recognizer, &block)
      @recognizer.add_group(group)
    end

    def configure
      yield self if block_given?
    end

  end

end