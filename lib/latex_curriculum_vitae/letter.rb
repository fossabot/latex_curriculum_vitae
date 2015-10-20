#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Notifier Module for latex_curriculum_vitae
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'fileutils'
require 'rainbow/ext/string'

# Module for creating the motivational letter
module LatexCurriculumVitae
  module Letter
    # Method for creating a pdf from tex
    def self.create_letter(tmpdir, name_of_letter)
      puts 'Compiling motivational letter'.colour(:yellow)
      system("pdflatex #{name_of_letter}.tex")
      puts 'Done compiling motivational letter'.colour(:green)
      system("cp #{name_of_letter}.pdf #{tmpdir}")
      puts 'Copied motivational letter to tmpdir'.colour(:green)
    end
  end
end
