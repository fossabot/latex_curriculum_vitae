# Copyright (C) 2015-2017 Sascha Manns <Sascha.Manns@mailbox.org>
#
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
    # Method for getting information
    # @param [String] entity_tex Path to the entity.tex
    # @return [Array] contact, email_address, job_title, contact_sex, company, proactive, job_url
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
      job_title, proactive, letter, company, street, city, contact_sex, contact, email_address,
          target, job_url = resume.chomp.split('|')

      create_file(job_title, company, street, city, contact, entity_tex, contact_sex, proactive, target)
      [contact, email_address, job_title, contact_sex, company, letter, proactive, job_url, target]
    end

    # Method for shorten the URL
    # @param [String] job_url The Url to the job offer
    # @param [String] bit_ly_user The Username in Bit.ly
    # @param [String] bit_ly_apikey The Apikey from your Bit.ly User
    # @return [String] job_url_checked Returns the shortened Bit.ly URL
    def self.shorten_url(job_url, bit_ly_user, bit_ly_apikey)
      # TODO: Try to fix this in future
      # rubocop:disable Style/UnneededInterpolation
      authorize = UrlShortener::Authorize.new "#{bit_ly_user}", "#{bit_ly_apikey}"
      client = UrlShortener::Client.new authorize

      shorten = client.shorten("#{job_url}") # => UrlShortener::Response::Shorten object
      shorten.result # => returns a hash of all data returned from bitly
      shorten.urls # => Only returns the short urls look for more convenience methods in the UrlShortener::Response::Shorten class
      puts shorten.urls
      job_url_checked = shorten.urls
      return job_url_checked
    end

    # Method for creating the entity.tex
    # @param [String] job_title Title of the target job
    # @param [String] company Comanys name
    # @param [String] street Companies street
    # @param [String] city City of the company
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Sex of the contact
    # @param [String] entity_tex Path to the entity.tex
    # TODO: Try to fix this in future
    # This method smells of :reek:LongParameterList
    def self.create_file(job_title, company, street, city, contact, entity_tex, contact_sex, proactive, target)
      introduction = LatexCurriculumVitae::Entityfile.get_introduction(contact, contact_sex)
      subject, intro = LatexCurriculumVitae::Entityfile.get_subject_intro(proactive, job_title)
      address_string = LatexCurriculumVitae::Entityfile.get_address_string(company, contact, contact_sex, street, city)
      target_block = LatexCurriculumVitae::Entityfile.get_target_block(target)

      FileUtils.rm(entity_tex) if File.exist?(entity_tex)
      FileUtils.touch(entity_tex)
      # TODO: Try to fix this in future
      # rubocop:disable Layout/IndentHeredoc
      File.write "#{entity_tex}", <<TEXFILE
\\def\\jobtitle{#{job_title}}
\\def\\company{#{company}}
\\def\\contact{#{contact}}
\\def\\street{#{street}}
\\def\\city{#{city}}
\\def\\introduction{#{introduction}}
\\def\\subject{#{subject}}
\\def\\addressstring{#{address_string}}
\\def\\intro{#{intro}}
\\def\\targetblock{#{target_block}}
TEXFILE
    end

    # Method for preparing the introduction variable
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Sex of the contact
    # @return [String] introduction
    # TODO: Try to fix this in future
    # rubocop:disable Style/IfInsideElse
    # This method smells of :reek:ControlParameter
    def self.get_introduction(contact, contact_sex)
      introduction = if contact == ''
                       'Sehr geehrte Damen und Herren,'
                     else
                       if contact_sex == 'male'
                         "Sehr geehrter Herr #{contact},"
                       else
                         "Sehr geehrte Frau #{contact},"
                       end
                     end
      return introduction
    end

    # Method for preparing the subject and intro variables
    # @param [String] proactive Can be yes or no
    # @param [String] job_title Title of the target job
    # @return [Array] subject intro
    # TODO: Try to fix this in future
    # This method smells of :reek:ControlParameter
    def self.get_subject_intro(proactive, job_title)
      if proactive == 'yes'
        subject = "Initiativbewerbung um einen Arbeitsplatz als #{job_title}"
        intro = "gerne möchte ich mich bei Ihnen um die Stelle als #{job_title} oder einer ähnlichen Position bewerben."
      else
        subject = "Bewerbung um einen Arbeitsplatz als #{job_title}"
        intro = "mit großem Interesse bin ich auf die ausgeschriebene Position aufmerksam geworden. Aus diesem Grund bewerbe ich mich bei Ihnen als #{job_title}."
      end
      [subject, intro]
    end

    # Method for preparing the address_string
    # @param [String] company Comanys name
    # @param [String] street Companies street
    # @param [String] city City of the company
    # @param [String] contact Name of the contact
    # @return [String] address_string
    # TODO: Try to fix this in future
    # This method smells of :reek:LongParameterList
    # This method smells of :reek:ControlParameter
    def self.get_address_string(company, contact, contact_sex, street, city)
      address_string = "#{company} \\\\"
      address_string << if contact == ''
                          'z.Hd. Personalabteilung \\\\'
                        else
                          if contact_sex == 'male'
                            "z.Hd. Herrn #{contact} \\\\"
                          else
                            "z.Hd. Frau #{contact} \\\\"
                          end
                        end
      address_string << "#{street} \\\\" if street != ''
      address_string << "#{city}" if city != ''
      return address_string
    end

    # Method for getting the target code block
    # @param [String] target The chosen target
    # @returns [String] target_block Returns a Block with the chosen Information
    # TODO: Try to fix this in future
    # This method smells of :reek:ControlParameter
    def self.get_target_block(target)
      if target == 'doku'
        target_block = 'Neben der Beschreibungssprache DocBook samt XSL-FO lernte ich die Satzsprache \\LaTeX. \\\\
Selbstständig erarbeitete ich mir Kenntnisse in der Programmiersprache Ruby, Python, sowie der Web-App-Entwicklung
(TH Mittelrhein).\\\\'
      elsif target == 'support'
        target_block = 'Im IT-Support hatte ich bereits erste Führungserfahrung als Dispatcher \\&Controller.
Selbstständig erarbeitete ich mir Kenntnisse in den Programmiersprachen Bash, Ruby und Python, sowie der Web-App-Entwicklung (TH Mittelrhein).\\\\'
      else
        target_block = 'Im kaufmännischen Bereich habe ich bereits vielfältige Erfahrungen im Einkauf, Verkauf,
Öffentlichkeitsarbeit und Vertrieb gemacht und bin stets bereit neues zu lernen.\\\\'
      end
      return target_block
    end
  end
end
