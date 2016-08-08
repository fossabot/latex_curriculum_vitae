# encoding: utf-8
# @author Sascha Manns
# @abstract CV Module for creating the curriculum vitae
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'rainbow/ext/string'

# main Module
module LatexCurriculumVitae
  # Module for creating the CV
  module CV
    # Create Curriculum Vitae method
    # @param [String] name_of_pdf Name of the resulting PDF file
    # @param [String] name_of_resume Name of the resume file
    # @param [String] tmpdir contains the path to the
    def self.create_cv(name_of_resume, tmpdir)
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
    # @param [String] letter With motivational letter? Can be yes or no
    # @param [String] name_of_letter Name of the motivational letter file
    # @param [String] name_of_resume Name of the resume file
    def self.create_final_cv(letter, name_of_letter, name_of_resume)
      # pdfunite in-1.pdf in-2.pdf in-n.pdf out.pdf
      if letter == 'yes'
        puts 'Merging the motivational letter with the cv'.colour(:yellow)
        system("pdfunite #{name_of_letter}.pdf #{name_of_resume}.pdf result.pdf")
        puts 'Merging done'.colour(:green)
      else
        puts "Copying #{name_of_resume}.pdf result.pdf".colour(:green)
        system("cp #{name_of_resume}.pdf result.pdf")
        puts 'Done'.colour(:green)
      end
    end

    # Shrink and get final compiled pdf
    # @param [String] name_of_pdf Name of the resulting PDF file
    def self.shrink_cv(name_of_pdf)
      puts 'Shrinking PDF'.colour(:yellow)
      system("gs -o #{name_of_pdf}.pdf -sDEVICE=pdfwrite -dPDFSETTINGS=/prepress result.pdf")
      puts 'Shrinking done'.colour(:yellow)
    end

    # Copy result to .latex_curriculum_vitae
    # @param [String] name_of_pdf Name of the resulting PDF file
    def self.copy_home(name_of_pdf)
      puts "Copying #{name_of_pdf}.pdf to tmpdir".colour(:yellow)
      system("cp #{name_of_pdf}.pdf #{Dir.home}/.latex_curriculum_vitae")
      puts 'Copied to tmpdir'.colour(:green)
    end
  end
end
