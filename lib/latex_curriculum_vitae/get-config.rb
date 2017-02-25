#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract module for getting information from a config file
#
# Copyright (C) 2015-2017  Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# Dependencies
require 'parseconfig'

# main module
module LatexCurriculumVitae
  # Module for creating the GetConfig
  module GetConfig
    # This method gets the configs from the config file
    # @return [Array] name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url, bitly_user, bitly_apikey
    def self.get(sysconfdir)
      home = Dir.home
      config = ParseConfig.new("#{sysconfdir}/latex_curriculum_vitae.cfg")
      name_of_pdf = config['name_of_pdf']
      name_of_cover = config['name_of_cover']
      name_of_resume = config['name_of_resume']
      name_of_letter = config['name_of_letter']
      pdf_reader = config['pdf_reader']
      shorten_url = config['shorten_url']
      bitly_user = config['bitly_user']
      bitly_apikey = config['bitly_apikey']

      [name_of_pdf, name_of_cover, name_of_resume, name_of_letter, pdf_reader, shorten_url, bitly_user, bitly_apikey]
    end

    # Method for getting smtp configuration
    # @return [Array] own_name, own_email_address, own_smtp, own_username, own_password, own_port, own_domain, own_tls
    def self.get_smtp(sysconfdir)
      home = Dir.home
      config = ParseConfig.new("#{sysconfdir}/latex_curriculum_vitae.cfg")
      # own_name = config['own_name']
      own_email_address = config['own_email_address']
      own_smtp = config['own_smtp']
      own_username = config['own_username']
      own_password = config['own_password']
      own_port = config['own_port'].to_i
      own_tls = config['own_tls']

      [own_email_address, own_smtp, own_username, own_password, own_port, own_tls]
    end

  end
end
