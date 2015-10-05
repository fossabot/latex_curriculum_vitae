#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract GetConfig Module for latex_curriculum_vitae
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'parseconfig'

# Module for creating the GetConfig
module Getconfig
  # This method gets the configs from the config file
  # @return [String] name_of_pdf Names the output PDF file
  def self.get
    home = Dir.home
    config = ParseConfig.new("#{home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg")
    name_of_pdf = config['name_of_pdf']
    name_of_cover = config['name_of_cover']
    name_of_resume = config['name_of_resume']
    name_of_letter = config['name_of_letter']
    [name_of_pdf, name_of_cover, name_of_resume, name_of_letter]
  end
end
