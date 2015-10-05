#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract CoverModule for latex_curriculum_vitae
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'rainbow/ext/string'

# Cover module
module Cover
  # Create cover method
  def self.create_cover(name_of_cover)
    puts 'Creating cover'.colour(:yellow)
    system("pdflatex #{name_of_cover}.tex")
    puts 'Creating cover done'.colour(:green)
  end
end
