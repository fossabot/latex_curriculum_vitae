#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract GetConfig Module for latex_curriculum_vitae
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'parseconfig'

# main module
module LatexCurriculumVitae
  # Module for creating the GetConfig
  module GetConfig
    # This method gets the configs from the config file
    # @return [Array] name_of_pdf, name_of_cover, name_of_resume, name_of_letter
    def self.get
      home = Dir.home
      config = ParseConfig.new("#{home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg")
      name_of_pdf = config['name_of_pdf']
      name_of_cover = config['name_of_cover']
      name_of_resume = config['name_of_resume']
      name_of_letter = config['name_of_letter']
      pdf_reader = config['pdf_reader']
      [name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader]
    end

    # Method for getting smtp configuration
    # @return [Array] own_name, own_email_address, own_smtp, own_username, own_password
    def self.get_smtp
      home = Dir.home
      config = ParseConfig.new("#{home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg")
      # own_name = config['own_name']
      own_email_address = config['own_email_address']
      own_smtp = config['own_smtp']
      own_username = config['own_username']
      own_password = config['own_password']

      [own_email_address, own_smtp, own_username, own_password]
    end

  end
end
