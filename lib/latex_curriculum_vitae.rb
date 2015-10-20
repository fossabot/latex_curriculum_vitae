#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Main Class for latex_curriculum_vitae
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# rubocop:disable Metrics/LineLength
# rubocop:disable Style/LeadingCommentSpace

# Dependencies
require 'fileutils'

require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/entityfile'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/cv'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/cover'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/email'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/outfile'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/notifier'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/letter'))
require File.expand_path(File.join(File.dirname(__FILE__), 'latex_curriculum_vitae/get-config'))

# Main Class LatexCurriculumVitae
module LatexCurriculumVitae
  # The version information
  VERSION = '1.1.0'

  # Variables
  home = Dir.home
  prefix = "#{home}/.rvm/rubies/default"
  datadir = "#{prefix}/share"
  entitytex = "#{home}/.latex_curriculum_vitae/entity.tex"
  csvout = "#{home}/.latex_curriculum_vitae/job-applications.csv"
  sharedir ="#{datadir}/latex_curriculum_vitae/Motivational_Letter"
  tmpdir = "#{datadir}/latex_curriculum_vitae/tmp"
  name_of_pdf, name_of_cover, name_of_resume, name_of_letter = LatexCurriculumVitae::GetConfig.get

  # Get the needed Information for creating the application
  contact, emailaddress, jobtitle, contact_sex, company, letter, proactive =
      LatexCurriculumVitae::Entityfile.get_information(entitytex)

  # Create Motivational Letter
  if letter == 'yes'
    FileUtils.cd("#{datadir}/latex_curriculum_vitae/Motivational_Letter") do
      LatexCurriculumVitae::Letter.create_letter(tmpdir, name_of_letter)
    end
  end

  # Create the cover
  FileUtils.cd("#{datadir}/latex_curriculum_vitae/Cover") do
    LatexCurriculumVitae::Cover.create_cover(name_of_cover)
  end

  # Create the Curriculum Vitae
  FileUtils.cd("#{datadir}/latex_curriculum_vitae/Resume") do
    LatexCurriculumVitae::CV.create_cv(name_of_pdf, name_of_resume, tmpdir)
  end

  # Final create and shrinking
  FileUtils.cd(tmpdir) do
    LatexCurriculumVitae::CV.create_final_cv(letter, name_of_letter, name_of_resume)
    LatexCurriculumVitae::CV.shrink_cv(name_of_pdf)
    LatexCurriculumVitae::CV.copy_home(name_of_pdf)
  end

  # Start evince to check the output file
  system("evince #{home}/.latex_curriculum_vitae/#{name_of_pdf}.pdf")

  LatexCurriculumVitae::Email.resultok(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf)

  # # Add entry to Outfile
  CVOutfile.add_to_outfile(jobtitle, company, contact, emailaddress, csvout)

  # Cleanup tmpdir
  FileUtils.cd(tmpdir) do
    allfiles = Dir.glob("*")
    allfiles.each do |data|
      File.delete(data)
    end
  end

  # Inform about creation is done
  LatexCurriculumVitae::Notify.run(jobtitle)
end
