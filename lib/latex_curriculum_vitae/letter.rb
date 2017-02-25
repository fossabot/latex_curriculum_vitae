#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract module for creating a motivational letter
#
# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# Dependencies
require 'fileutils'
require 'rainbow/ext/string'

# main module
module LatexCurriculumVitae
  # Module for creating the motivational letter
  module Letter
    # Method for creating a pdf from tex
    # @param [String] tmpdir Name of the Tempdir
    # @param [String] name_of_letter Filename of the Letter
    def self.create_letter(tmpdir, name_of_letter)
      puts 'Compiling motivational letter'.colour(:yellow)
      system("pdflatex #{name_of_letter}.tex")
      puts 'Done compiling motivational letter'.colour(:green)
      system("cp #{name_of_letter}.pdf #{tmpdir}")
      puts 'Copied motivational letter to tmpdir'.colour(:green)
    end
  end
end
