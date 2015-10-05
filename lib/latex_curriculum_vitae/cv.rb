#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract CV Module for latex_curriculum_vitae
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'rainbow/ext/string'

# Module for creating the CV
module CV
  # Create Curriculum Vitae method
  # @param [string] tmpdir contains the path to the
  def self.create_cv(name_of_pdf, name_of_resume, tmpdir)
    puts 'First run of xelatex'.colour(:yellow)
    system("xelatex #{name_of_resume}.tex")
    puts 'First run of xelatex passed'.colour(:yellow)
    puts 'Running biber'.colour(:yellow)
    system("biber #{name_of_resume}.bcf")
    puts 'Run of biber passed'.colour(:yellow)
    puts 'Second run of xelatex'.colour(:yellow)
    system("xelatex #{name_of_resume}.tex")
    puts 'Second run of xelatex passed'.colour(:yellow)
    puts 'All done'.colour(:green)
    system("cp #{name_of_resume}.pdf #{tmpdir}/#{name_of_resume}.pdf")
  end

  # Create the final cv
  def self.create_final_cv(letter, name_of_letter, name_of_resume)
    # pdfunite in-1.pdf in-2.pdf in-n.pdf out.pdf
    if letter == 'yes'
      puts 'Merging the motivational letter with the cv'.colour(:yellow)
      system("pdfunite #{name_of_letter}.pdf #{name_of_resume}.pdf result.pdf")
      puts 'Merging done'.colour(:green)
    else
      puts "Copying #{name_of_resume}.tex result.pdf".colour(:green)
      system("cp #{name_of_resume}.pdf result.pdf")
      puts  'Done'.colour(:green)
    end
  end

  # Schrink and get final compiled pdf
  def self.shrink_cv(name_of_pdf)
    puts 'Shrinking PDF'.colour(:yellow)
    system("gs -o #{name_of_pdf}.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress result.pdf")
    puts 'Shrinking done'.colour(:yellow)
  end

  # Copy result to .latex_curriculum_vitae
  def self.copy_home(name_of_pdf)
    puts "Copying #{name_of_pdf}.pdf to tmpdir".colour(:yellow)
    system("cp #{name_of_pdf}.pdf #{Dir.home}/.latex_curriculum_vitae")
    puts 'Copied to tmpdir'.colour(:green)
  end
end
