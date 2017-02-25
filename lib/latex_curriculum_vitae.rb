#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Main Module for latex_curriculum_vitae
#
# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# rubocop:disable Metrics/LineLength

# Dependencies
require 'fileutils'
require 'xdg'
require 'tmpdir'

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
  VERSION = '2.0.0'

  # Variables
  sysxdg = XDG['CONFIG_HOME']
  dataxdg = XDG['DATA_HOME']
  sysconfdir = "#{sysxdg}/latex_curriculum_vitae"
  datadir = "#{dataxdg}/latex_curriculum_vitae"
  entitytex = "#{sysconfdir}/entity.tex"
  csvout = "#{sysconfdir}/job-applications.csv"
  tempdir = '/tmp/latex_curriculum_vitae'
  tmpdir = "#{tempdir}/build"

  name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url, bitly_user, bitly_apikey =
      LatexCurriculumVitae::GetConfig.get(sysconfdir)

  # Get the needed Information for creating the application
  contact, emailaddress, jobtitle, contact_sex, company, letter, proactive, job_url =
      LatexCurriculumVitae::Entityfile.get_information(entitytex)

  # Shorten shorten_url
  if proactive == 'yes'
   joburl = 'No URL available (Proactive)'
  else
    if shorten_url == 'yes'
      if shorten_url != ''
        joburl = LatexCurriculumVitae::Entityfile.shorten_url(job_url, bitly_user, bitly_apikey)
      else
        puts 'No url given'
      end
    else
      joburl = job_url
    end
  end

  # Copy data to tempdir
  if Dir.exist?(tempdir) == 'true'
    FileUtils.rm_rf(tempdir)
  end
  FileUtils.mkdir(tempdir)
  FileUtils.cp_r("#{datadir}/.", "#{tempdir}")
  FileUtils.mkdir(tmpdir)

  # Create Motivational Letter
  if letter == 'yes'
    FileUtils.cd("#{tempdir}/Motivational_Letter") do
      LatexCurriculumVitae::Letter.create_letter(tmpdir, name_of_letter)
    end
  end

  # Create the cover
  FileUtils.cd("#{tempdir}/Cover") do
    LatexCurriculumVitae::Cover.create_cover(name_of_cover, tmpdir)
  end

  # Create the Curriculum Vitae
  FileUtils.cd("#{tempdir}/Resume") do
    LatexCurriculumVitae::CV.create_cv(name_of_resume, tmpdir)
  end

  # Final create and shrinking
  FileUtils.cd(tmpdir) do
    LatexCurriculumVitae::CV.create_final_cv(letter, name_of_letter, name_of_resume, name_of_pdf, name_of_cover)
    LatexCurriculumVitae::CV.copy_home(name_of_pdf, datadir)
  end

  # Add entry to Outfile
  CVOutfile.add_to_outfile(jobtitle, company, contact, emailaddress, csvout, joburl)

  # Start evince to check the output file
  system("#{pdf_reader} #{datadir}/#{name_of_pdf}.pdf")

  # Ask if result is ok
  LatexCurriculumVitae::Email.resultok(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf, sysconfdir, datadir)

  # Inform about creation is done
  LatexCurriculumVitae::Notify.run(jobtitle, datadir)

  # Remove tempdir
  FileUtils.rm_rf(tempdir)
end
