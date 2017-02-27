#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract module for notify the user about finishing the email send
# process
#
# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

# Dependencies

# Module for notify the user
require 'notifier'

# main module
module LatexCurriculumVitae
  # Method for notifying the user
  module Notify
    # @param [String] jobtitle The Title of your job application
    def self.run(jobtitle, datadir)
      img = "#{datadir}/share/icons/arbeitsagentur.png"
      Notifier.notify(
          :image => "#{img}",
          :title => "Your Job Application",
          :message => "Your Job Application #{jobtitle} was created now."
      )
    end
  end
end
