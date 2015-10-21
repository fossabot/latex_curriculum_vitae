#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract Entityfile Module for latex_curriculum_vitae
#
# Copyright (C) 2015  Sascha Manns <samannsml@directbox.com>
# License: MIT

# Dependencies
require 'fileutils'
require 'rainbow/ext/string'

# main module
module LatexCurriculumVitae
  # Module for creating the entityfile
  module Entityfile
    # rubocop:disable Metrics/LineLength
    # Method for getting information
    # @param [String] entitytex Path to the entity.tex
    # @return [Array] contact, emailaddress, jobtitle, contact_sex, company, proactive:q:q
    def self.get_information(entitytex)
      resume = `yad --title="Create application" --center --on-top --form \
--item-separator=, --separator="|" \
--field="What is the jobtitle of your application? Escape amp with backslash:TEXT" \
--field="Is it a proactive application?:CBE" \
--field="What is the companies name? Escape amp with backslash:TEXT" \
--field="Create a motivational letter?:CBE" \
--field="Give me the street of the company:TEXT" \
--field="What is the zip-code (german PLZ) and city from the company:TEXT" \
--field="Is your contact male or female? Leave blank if unknown contact:CBE" \
--field="If you have a contact so give me the name of him/her. Leave blank if unknown contact:TEXT" \
--field="Tell me the email address for sending the application:TEXT" \
--button="Go!" "" "yes,no" "" "yes,no" "" "" "male,female,unknown" "" ""`
      jobtitle, proactive, company, letter, street, city, contact_sex, contact, emailaddress = resume.chomp.split('|')
      [jobtitle, proactive, company, letter, street, city, contact_sex, contact, emailaddress].each do |s|
        puts s
      end

      create_file(jobtitle, company, street, city, contact, entitytex, contact_sex, proactive)
      [contact, emailaddress, jobtitle, contact_sex, company, letter, proactive]
    end

    # # Method for getting information through a real gui
    # def self.get_information_gui(entitytex)
    #   # TODO: Extend code for using the gtk GUI
    #   require 'gtk2'
    #   require 'libglade2'
    #   @threads = []
    #
    #   Gtk.init
    #
    #   @glade = GladeXML.new('glade/latexcv.glade')
    #   @glade.widget_names.each do |name|
    #     instance_variable_set("@#{name}".intern, @glade[name])
    #   end
    # end

    # Method for creating the entity.tex
    # @param [String] jobtitle Title of the target job
    # @param [String] company Comanys name
    # @param [String] street Companies street
    # @param [String] city City of the company
    # @param [String] contact Name of the contact
    # @param [String] entitytex Path to the entity.tex
    def self.create_file(jobtitle, company, street, city, contact, entitytex, contact_sex, proactive)
      if contact == ''
        introduction = 'Sehr geehrte Damen und Herren,'
      else
        if contact_sex == 'male'
          introduction = "Sehr geehrter Herr #{contact},"
        else
          introduction = "Sehr geehrte Frau #{contact},"
        end
      end
      if proactive == 'yes'
        subject = "Initiativbewerbung um einen Arbeitsplatz als #{jobtitle}"
        intro = 'Gerne möchte ich mich bei Ihnen um die obige oder eine vergleichbare Stelle bewerben.'
      else
        subject = "Bewerbung um einen Arbeitsplatz als #{jobtitle}"
        intro = 'Wie ich Ihrer Anzeige entnommen habe, suchen Sie jemanden für die obige Position, um die ich mich bewerbe.'
      end

      addressstring = "#{company} \\\\"
      if contact == ''
        addressstring << 'z.Hd. Personalabteilung \\\\'
      else
        addressstring << "z.Hd. #{contact} \\\\"
      end
      addressstring << "#{street} \\\\" if street != ''
      addressstring << "#{city}" if city != ''

      FileUtils.rm(entitytex) if File.exist?(entitytex)
      FileUtils.touch(entitytex)
      File.write "#{entitytex}", <<EOF
\\def\\jobtitle{#{jobtitle}}
\\def\\company{#{company}}
\\def\\contact{#{contact}}
\\def\\street{#{street}}
\\def\\city{#{city}}
\\def\\introduction{#{introduction}}
\\def\\subject{#{subject}}
\\def\\addressstring{#{addressstring}}
\\def\\intro{#{intro}}
EOF
    end
  end
end
