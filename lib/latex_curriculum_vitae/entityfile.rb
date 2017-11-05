# encoding: utf-8
# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
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
require 'fileutils'
require 'rainbow/ext/string'
require 'url_shortener'

# main module
module LatexCurriculumVitae
  # Module for creating the entityfile
  module Entityfile
    # TODO: Try to fix this in future
    # rubocop:disable Metrics/LineLength
    # rubocop:disable Metrics/MethodLength
    # Method for getting information
    # @param [String] entitytex Path to the entity.tex
    # @return [Array] contact, emailaddress, jobtitle, contact_sex, company, proactive, job_url
    def self.get_information(entity_tex)
      resume = `yad --title="Create application" --center --on-top --form --item-separator=, --separator="|" \
--field="What is the jobtitle of your application? Escape amp with backslash:TEXT" \
--field="Is it a proactive application?:CBE" \
--field="Create a motivational letter?:CBE" \
--field="What is the companies name? Escape amp with backslash:TEXT" \
--field="Give me the street of the company:TEXT" \
--field="What is the zip-code (german PLZ) and city from the company:TEXT" \
--field="Is your contact male or female? Leave blank if unknown contact:CBE" \
--field="If you have a contact so give me the name of him/her. Leave blank if unknown contact:TEXT" \
--field="Tell me the email address for sending the application:TEXT" \
--field="What kind of target:CBE" \
--field="Tell me the URL of the job offer:TEXT" \
--button="Go!" "" "no,yes" "yes,no" "" "" "" "male,female,unknown" "" "" "doku,support,kaufm"`
      job_title, proactive, letter, company, street, city, contact_sex, contact, email_address, target, job_url =
          resume.chomp.split('|')
      [job_title, proactive, letter, company, street, city, contact_sex, contact, email_address, target,
       job_url].each do |s|
        puts s
      end

      create_file(job_title, company, street, city, contact, entity_tex, contact_sex, proactive, target)
      [contact, email_address, job_title, contact_sex, company, letter, proactive, job_url]
    end

    # Method for shorten the URL
    # @param [String] job_url The Url to the job offer
    # @param [String] bitly_user The Username in Bit.ly
    # @param [String] bitly_apikey The Apikey from your Bit.ly User
    # @return [String] joburl Returns the shortened Bit.ly URL
    def self.shorten_url(job_url, bit_ly_user, bit_ly_apikey)
      authorize = UrlShortener::Authorize.new "#{bit_ly_user}", "#{bit_ly_apikey}"
      client = UrlShortener::Client.new authorize

      shorten = client.shorten("#{job_url}") # => UrlShortener::Response::Shorten object
      shorten.result # => returns a hash of all data returned from bitly
      shorten.urls # => Only returns the short urls look for more convenience methods in the UrlShortener::Response::Shorten class
      puts shorten.urls
      joburl = shorten.urls
      return joburl
    end

    # Method for creating the entity.tex
    # @param [String] jobtitle Title of the target job
    # @param [String] company Comanys name
    # @param [String] street Companies street
    # @param [String] city City of the company
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Sex of the contact
    # @param [String] entitytex Path to the entity.tex
    def self.create_file(job_title, company, street, city, contact, entity_tex, contact_sex, proactive, target)
      introduction = LatexCurriculumVitae::Entityfile.get_introduction(contact, contact_sex)
      subject, intro = LatexCurriculumVitae::Entityfile.get_subject_intro(proactive, job_title)
      addressstring = LatexCurriculumVitae::Entityfile.get_address_string(company, contact, contact_sex, street, city)
      targetblock = LatexCurriculumVitae::Entityfile.get_target_block(target)

      FileUtils.rm(entity_tex) if File.exist?(entity_tex)
      FileUtils.touch(entity_tex)
      File.write "#{entity_tex}", <<EOF
\\def\\jobtitle{#{job_title}}
\\def\\company{#{company}}
\\def\\contact{#{contact}}
\\def\\street{#{street}}
\\def\\city{#{city}}
\\def\\introduction{#{introduction}}
\\def\\subject{#{subject}}
\\def\\addressstring{#{addressstring}}
\\def\\intro{#{intro}}
\\def\\targetblock{#{targetblock}}
EOF
    end

    # Method for preparing the introduction variable
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Sex of the contact
    # @return [String] introduction
    def self.get_introduction(contact, contact_sex)
      if contact == ''
        introduction = 'Sehr geehrte Damen und Herren,'
      else
        if contact_sex == 'male'
          introduction = "Sehr geehrter Herr #{contact},"
        else
          introduction = "Sehr geehrte Frau #{contact},"
        end
      end
      return introduction
    end

    # Method for preparing the subject and intro variables
    # @param [String] proactive Can be yes or no
    # @param [String] jobtitle Title of the target job
    # @return [Array] subject intro
    def self.get_subject_intro(proactive, job_title)
      if proactive == 'yes'
        subject = "Initiativbewerbung um einen Arbeitsplatz als #{job_title}"
        intro = "gerne möchte ich mich bei Ihnen um die Stelle als #{job_title} oder einer ähnlichen Position bewerben."
      else
        subject = "Bewerbung um einen Arbeitsplatz als #{job_title}"
        intro = "mit großem Interesse bin ich auf die ausgeschriebene Position aufmerksam geworden. Aus diesem Grund bewerbe ich mich bei Ihnen als #{jobtitle}."
      end
      [subject, intro]
    end

    # Method for preparing the addressstring
    # @param [String] company Comanys name
    # @param [String] street Companies street
    # @param [String] city City of the company
    # @param [String] contact Name of the contact
    # @return [String] addressstring
    def self.get_address_string(company, contact, contact_sex, street, city)
      addressstring = "#{company} \\\\"
      if contact == ''
        addressstring << 'z.Hd. Personalabteilung \\\\'
      else
        if contact_sex == 'male'
          addressstring << "z.Hd. Herrn #{contact} \\\\"
        else
          addressstring << "z.Hd. Frau #{contact} \\\\"
        end
      end
      addressstring << "#{street} \\\\" if street != ''
      addressstring << "#{city}" if city != ''
      return addressstring
    end

    # Method for getting the target code block
    # @param [String] target The choosed target
    # @returns [String] targetblock Returns a Block with the choosed Information
    def self.get_target_block(target)
      if target == 'doku'
        targetblock = 'Neben der Beschreibungssprache DocBook samt XSL-FO lernte ich die Satzsprache \\LaTeX. \\\\ Selbstständig erarbeitete ich mir Kenntnisse in der Programmiersprache Ruby, sowie der Web-App-Entwicklung (Technische Hochschule Mittelrhein).\\\\'
      elsif target == 'support'
        targetblock = 'Im IT-Support hatte ich bereits erste Führungserfahrung als Dispatcher \\&Controller. Selbstständig erarbeitete ich mir Kenntnisse in den Programmiersprachen Bash, Ruby und Python, sowie der Web-App-Entwicklung (Technische Hochschule Mittelrhein).\\\\'
      else
        targetblock = 'Im kaufmännischen Bereich habe ich bereits vielfältige Erfahrungen im Einkauf, Verkauf, Öffentlichkeitsarbeit und Vertrieb gemacht und bin stets bereit neues zu lernen.\\\\'
      end
    end
  end
end
