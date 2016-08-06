#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Notifier Module for latex_curriculum_vitae
#
# Copyright (C) 2015-2016  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies

# Module for notify the user
require 'notifier'

# main module
module LatexCurriculumVitae
  # Method for notifying the user
  module Notify
    def self.run(jobtitle)
      home = Dir.home
      prefix = "#{home}/.rvm/rubies/default"
      datadir = "#{prefix}/share"
      img = "#{datadir}/latex_curriculum_vitae/Pictures/arbeitsagentur.png"
      Notifier.notify(
          :image => "#{img}",
          :title => "Your Job Application",
          :message => "Your Job Application #{jobtitle} was created now."
      )
    end
  end
end
