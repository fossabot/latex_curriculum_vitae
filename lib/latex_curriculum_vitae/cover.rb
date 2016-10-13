# encoding: utf-8
# @author Sascha Manns
# @abstract A module for creating the latex cover
#
# Copyright (C) 2015-2016  Sascha Manns <Sascha.Manns@directbox.com>
# License: MIT

# Dependencies
require 'rainbow/ext/string'

# main module
module LatexCurriculumVitae
  # Cover module
  module Cover
    # Create cover method
    # @param [String] name_of_cover Name of the cover file
    def self.create_cover(name_of_cover, tmpdir)
      puts 'Creating cover'.colour(:yellow)
      system("pdflatex #{name_of_cover}.tex")
      system("cp #{name_of_cover}.pdf #{tmpdir}/#{name_of_cover}.pdf")
      puts 'Creating cover done'.colour(:green)
    end
  end
end
