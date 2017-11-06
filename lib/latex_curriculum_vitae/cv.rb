# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Dependencies
require 'rainbow/ext/string'
require 'combine_pdf'
require 'fileutils'

# main Module
module LatexCurriculumVitae
  # Module for creating the CV
  module CV
    # Create Curriculum Vitae method
    # TODO: Try to fix this in future
    # rubocop:disable Metrics/AbcSize
    # @param [String] name_of_pdf Name of the resulting PDF file
    # @param [String] name_of_resume Name of the resume file
    # @param [String] tmp_dir contains the path to the
    def self.create_cv(name_of_resume, tmp_dir)
      puts 'First run of xelatex'.color(:yellow)
      system("xelatex #{name_of_resume}.tex")
      puts 'First run of xelatex passed'.color(:yellow)
      puts 'Running biber'.color(:yellow)
      system("biber #{name_of_resume}.bcf")
      puts 'Run of biber passed'.color(:yellow)
      puts 'Second run of xelatex'.color(:yellow)
      system("xelatex #{name_of_resume}.tex")
      puts 'Second run of xelatex passed'.color(:yellow)
      puts 'All done'.color(:green)
      system("cp #{name_of_resume}.pdf #{tmp_dir}/#{name_of_resume}.pdf")
    end

    # Create the final cv
    # @param [String] letter With motivational letter? Can be yes or no
    # @param [String] name_of_letter Name of the motivational letter file
    # @param [String] name_of_resume Name of the resume file
    # @param [String] name_of_pdf Name of the finished pdf
    # @param [String] name_of_cover Name of the Cover file
    # TODO: Try to fix this in future
    # This method smells of :reek:LongParameterList
    # This method smells of :reek:ControlParameter
    def self.create_final_cv(letter, name_of_letter, name_of_resume, name_of_pdf, name_of_cover)
      if letter == 'yes'
        puts 'Merging the motivational letter with the cv'.color(:yellow)
        pdf = CombinePDF.new
        pdf << CombinePDF.load("#{name_of_letter}.pdf")
        pdf << CombinePDF.load("#{name_of_cover}.pdf")
        pdf << CombinePDF.load("#{name_of_resume}.pdf")
        pdf.save 'result.pdf'
        puts 'Merging done'.color(:green)
      else
        puts "Copying #{name_of_resume}.pdf result.pdf".color(:green)
        pdf = CombinePDF.new
        pdf << CombinePDF.load("#{name_of_cover}.pdf")
        pdf << CombinePDF.load("#{name_of_resume}.pdf")
        pdf.save 'resumenew.pdf'
        system('cp resumenew.pdf result.pdf')
        puts 'Done'.color(:green)
      end
      appendix(name_of_pdf)
    end

    # Add additional stuff
    # @param [String] name_of_pdf Name of the finished pdf
    def self.appendix(name_of_pdf)
      puts 'Adding additional stuff'.color(:yellow)
      pdf = CombinePDF.new
      pdf << CombinePDF.load('result.pdf')
      # Put there your own stuff
      pdf << CombinePDF.load('../Appendix/Employers_Reference/xcom.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/hays.pdf')
      pdf << CombinePDF.load('../Appendix/Certificates/thm-webeng1.pdf')
      pdf << CombinePDF.load('../Appendix/Certificates/kompetenzpass12013.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/openslx.pdf')
      pdf << CombinePDF.load('../Appendix/Employers_Reference/openslx1.pdf')
      pdf << CombinePDF.load('../Appendix/Certificates/Zertifikat_Sascha_Manns1.pdf')
      pdf << CombinePDF.load('../Appendix/First_References/ihk.pdf')
      pdf.save "#{name_of_pdf}.pdf"
      puts 'Additional stuff done'.color(:green)
    end

    # Copy result to .latex_curriculum_vitae
    # @param [String] name_of_pdf Name of the resulting PDF file
    # @param [String] data_dir Path to the data dir
    def self.copy_home(name_of_pdf, data_dir)
      puts "Copying #{name_of_pdf}.pdf to tmpdir".color(:yellow)
      system("cp #{name_of_pdf}.pdf #{data_dir}")
      puts 'Copied to tmpdir'.color(:green)
    end
  end
end
