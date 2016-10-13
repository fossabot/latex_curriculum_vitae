# encoding: utf-8
# @author Sascha Manns
# @abstract CV Module for creating the curriculum vitae
#
# Copyright (C) 2015-2016  Sascha Manns <Sascha.Manns@directbox.com>
# License: MIT

# Dependencies
require 'rainbow/ext/string'
require 'combine_pdf'
require 'fileutils'

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
    # @param [String] name_of_pdf Name of the finished pdf
    # @param [String] name_of_cover Name of the Cover file
    def self.create_final_cv(letter, name_of_letter, name_of_resume, name_of_pdf, name_of_cover)
      if letter == 'yes'
        puts 'Merging the motivational letter with the cv'.colour(:yellow)
        pdf = CombinePDF.new
        pdf << CombinePDF.load("#{name_of_letter}.pdf") # one way to combine, very fast.
        pdf << CombinePDF.load("#{name_of_cover}.pdf")
        pdf << CombinePDF.load("#{name_of_resume}.pdf")
        pdf.save 'result.pdf'
        puts 'Merging done'.colour(:green)
      else
        puts "Copying #{name_of_resume}.pdf result.pdf".colour(:green)
        pdf = CombinePDF.new
        pdf << CombinePDF.load("#{name_of_cover}.pdf")
        pdf << CombinePDF.load("#{name_of_resume}.pdf")
        pdf.save 'resumenew.pdf'
        system('cp resumenew.pdf result.pdf')
        puts 'Done'.colour(:green)
      end
      appendix(name_of_pdf)
    end

    # Add additional stuff
    # @param [String] name_of_pdf Name of the finished pdf
    def self.appendix(name_of_pdf)
      puts 'Adding additional stuff'.colour(:yellow)
      pdf = CombinePDF.new
      pdf << CombinePDF.load('result.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/xcom.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/hays.pdf')
      pdf << CombinePDF.load('../Appendix/Certificates/thm-webeng1.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/openslx.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/openslx1.pdf')
      pdf << CombinePDF.load('../Appendix/Certificates/Zertifikat_Sascha_Manns1.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/wtg.pdf')
      pdf << CombinePDF.load('../Appendix/First_References/ihk.pdf')
      pdf.save "#{name_of_pdf}.pdf"
      puts 'Additional stuff done'.colour(:green)
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
