#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Main Module for latex_curriculum_vitae
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT

# rubocop:disable Metrics/LineLength

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
  VERSION = '1.3.0'

  # Variables
  home = Dir.home
  prefix = "#{home}/.rvm/rubies/default"
  datadir = "#{prefix}/share"
  entitytex = "#{home}/.latex_curriculum_vitae/entity.tex"
  csvout = "#{home}/.latex_curriculum_vitae/job-applications.csv"
  tmpdir = "#{datadir}/latex_curriculum_vitae/tmp"
  name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url, bitly_user, bitly_apikey = LatexCurriculumVitae::GetConfig.get

  # Get the needed Information for creating the application
  contact, emailaddress, jobtitle, contact_sex, company, letter, proactive, job_url =
      LatexCurriculumVitae::Entityfile.get_information(entitytex)

  # Disable VPN
  LatexCurriculumVitae::Entityfile.vpn_warning

  # Shorten shorten_url
  if shorten_url == 'yes'
    joburl = LatexCurriculumVitae::Entityfile.shorten_url(job_url, bitly_user, bitly_apikey)
  else
    joburl = job_url
  end

  # Create Motivational Letter
  if letter == 'yes'
    FileUtils.cd("#{datadir}/latex_curriculum_vitae/Motivational_Letter") do
      LatexCurriculumVitae::Letter.create_letter(tmpdir, name_of_letter)
    end
  end

  # Create the cover
  FileUtils.cd("#{datadir}/latex_curriculum_vitae/Cover") do
    LatexCurriculumVitae::Cover.create_cover(name_of_cover, tmpdir)
  end

  # Create the Curriculum Vitae
  FileUtils.cd("#{datadir}/latex_curriculum_vitae/Resume") do
    LatexCurriculumVitae::CV.create_cv(name_of_resume, tmpdir)
  end

  # Final create and shrinking
  FileUtils.cd(tmpdir) do
    LatexCurriculumVitae::CV.create_final_cv(letter, name_of_letter, name_of_resume, name_of_pdf, name_of_cover)
    LatexCurriculumVitae::CV.copy_home(name_of_pdf)
  end

  # Add entry to Outfile
  CVOutfile.add_to_outfile(jobtitle, company, contact, emailaddress, csvout, joburl)

  # Start evince to check the output file
  system("#{pdf_reader} #{home}/.latex_curriculum_vitae/#{name_of_pdf}.pdf")

  # Ask if result is ok
  LatexCurriculumVitae::Email.resultok(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf)

  # Inform about creation is done
  LatexCurriculumVitae::Notify.run(jobtitle)
end
