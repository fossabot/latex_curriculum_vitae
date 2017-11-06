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
require 'rainbow/ext/string'
require 'pony'
require 'resolv-replace.rb'
require File.expand_path(File.join(File.dirname(__FILE__), 'get-config'))

# Module for creating the CV
module LatexCurriculumVitae
  # Module for creating the Email
  module Email
    # Method for creating the email
    # @param [String] contact Name of the contact
    # @param [String] email_address Email address of the contact
    # @param [String] job_title Title of the target job
    # @param [String] contact_sex Can be male, female or unknown
    # @param [String] proactive Can be yes or no
    # @param [String] letter For preparing the letter
    # @param [String] name_of_pdf Name of the output pdf
    # TODO: Try to fix this in future
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/ParameterLists
    # This method smells of :reek:LongParameterList
    # This method smells of :reek:ControlParameter
    def self.create_email(contact, email_address, job_title, contact_sex, proactive, letter, name_of_pdf, sysconf_dir,
                          data_dir, mail_backend, target)
      own_email_address, own_smtp, own_username, own_password,
          own_port = LatexCurriculumVitae::GetConfig.get_smtp(sysconf_dir)
      introduction = introduction(contact, contact_sex)
      subject = subject(proactive, job_title)
      body = get_body(introduction, letter, proactive, job_title, target)
      filename = "#{data_dir}/#{name_of_pdf}.pdf"

      if mail_backend == 'Pony'
        # More information about Pony Mailer: https://github.com/benprew/pony
        Pony.mail(to: email_address,
                  bcc: own_email_address,
                  from: own_email_address,
                  subject: subject,
                  body: body,
                  attachments: { 'Bewerbungsunterlagen_Manns.pdf' => File.read(filename) },
                  via: :smtp,
                  via_options: {
                    address: own_smtp,
                    port: own_port,
                    enable_starttls_auto: true,
                    user_name: own_username,
                    password: own_password,
                    authentication: :plain, # :plain, :login, :cram_md5, no auth by default
                    domain: 'localhost.localdomain', # the HELO domain provided by the client to the server
                  })
      else
        `evolution mailto:"#{email_address}?subject=#{subject}\&body=#{body}\&attach=#{filename}"`
      end
    end

    # Method for building the introduction
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Can be male, female or unknown
    # @return [String] Returns introduction
    # TODO: Try to fix this in future
    # rubocop:disable Style/IfInsideElse
    # This method smells of :reek:ControlParameter
    def self.introduction(contact, contact_sex)
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

    # Method for building the subject
    # @param [String] proactive Can be yes or no
    # @param [String] job_title Title of the target job
    # @return [Array] subject, intro
    # TODO: Try to fix this in future
    # This method smells of :reek:ControlParameter
    def self.subject(proactive, job_title)
      subject = if proactive == 'yes'
                  "Initiativbewerbung um einen Arbeitsplatz als #{job_title}"
                else
                  "Bewerbung um einen Arbeitsplatz als #{job_title}"
                end
      return subject
    end

    # Method for getting the email intro
    # TODO: Try to fix this in future
    # rubocop:disable Metrics/LineLength
    # This method smells of :reek:ControlParameter
    # @param [String] proactive Is this a proactive application yes/no
    # @param [String] job_title The job title
    # @return intro
    def self.get_intro(proactive, job_title)
      intro = if proactive == 'yes'
                "gerne möchte ich mich bei Ihnen um die Stelle als #{job_title} oder einer ähnlichen Position bewerben."
              else
                "mit großem Interesse bin ich auf die ausgeschriebene Position aufmerksam geworden. Aus diesem Grund bewerbe ich mich bei Ihnen als #{job_title}."
              end
      return intro
    end

    # Method for getting the target code block
    # @param [String] target The chosen target
    # @returns [String] target_block Returns a Block with the chosen Information
    # TODO: Try to fix this in future
    # This method smells of :reek:ControlParameter
    def self.get_target_block(target)
      if target == 'doku'
        target_block = 'Neben der Beschreibungssprache DocBook samt XSL-FO lernte ich die Satzsprache LaTeX.
Selbstständig erarbeitete ich mir Kenntnisse in den Programmiersprachen Ruby, Python, sowie der Web-App-Entwicklung
(TH Mittelrhein).'
      elsif target == 'support'
        target_block = 'Im IT-Support hatte ich bereits erste Führungserfahrung als Dispatcher und Controller.
Selbstständig erarbeitete ich mir Kenntnisse in den Programmiersprachen Bash, Ruby und Python, sowie der
Web-App-Entwicklung (TH Mittelrhein).'
      else
        target_block = 'Im kaufmännischen Bereich habe ich bereits vielfältige Erfahrungen im Einkauf, Verkauf,
Öffentlichkeitsarbeit und Vertrieb gemacht und bin stets bereit neues zu lernen.'
      end
      return target_block
    end

    # Method for building the email body
    # @param [String] introduction EMail introduction
    # @param [String] letter With motivational letter? Can be yes or no
    # @param [String] proactive Is this a proactive application yes/no
    # @param [String] job_title The job title
    # @return [String] body Returns the messagebody for the email
    # TODO: Try to fix this in future
    # rubocop:disable Layout/IndentHeredoc
    # This method smells of :reek:ControlParameter
    def self.get_body(introduction, letter, proactive, job_title, target)
      intro = get_intro(proactive, job_title)
      target_block = get_target_block(target)
      body = if letter == 'no'
               <<BODY
#{introduction}

#{intro}

Mit meinen vielfältigen Erfahrungen als Kaufmann, Community-
Manager, Buchautor und Customer Supporter (Level 1 und 2),
sowie Autor Geschäftsprozess- und Anwendungsdokumentation
könnte ich Ihr neuer Mitarbeiter sein.

Zuletzt war ich für die XCOM AG im Bereich der Dokumentation
tätig.

Seit dieser Zeit habe ich an teamgesteuerten Projekten für Kunden
mitgearbeitet, wobei mein Schwerpunkt im Bereich Kundenpflege via
Telefon und Email, Dispatching und Teamcontrolling lag.

#{target_block}

In für mich fremde Arbeitsgebiete werde ich mich rasch einarbeiten.
Meine Kenntnisse in IT und Organisationsfähigkeiten kann ich für Ihr
Unternehmen im Bereich des Managements gewinnbringend umsetzen.
Persönlich runde ich das Profil mit den Eigenschaften: Teamfähigkeit,
Kommunikationsstärke und Leistungsbereitschaft ab.

Ich bin mir sicher, die von Ihnen gewünschten Kenntnisse und
Fähigkeiten mitzubringen, und würde mich sehr über ein
Vorstellungsgespräch freuen.

--


Sincerly yours

Sascha Manns
Maifeldstraße 10
56727 Mayen
Phone: +49-1573-9242730 (mobile)
Phone: +49-2651-4014045 (home)
Email: Sascha.Manns@mailbox.org
Web: http://saigkill.tuxfamily.org
BODY
             else
               <<BODY
#{introduction}

gerne möchte ich mich bei Ihnen für die obige Stelle bewerben.
Meine digitale Bewerbungsmappe, samt des offiziellen Anschreibens,
sind der Mail als Anhang beigefügt.
--
Sincerly yours

Sascha Manns
Maifeldstraße 10
56727 Mayen
Phone: +49-1573-9242730 (mobile)
Phone: +49-2651-4014045 (home)
Email: Sascha.Manns@mailbox.org
Web: http://saigkill.tuxfamily.org
BODY
             end
      return body
    end

    # Method for checking the result
    # @param [String] contact Name of the contact
    # @param [String] email_address Email address from the contact
    # @param [String] job_title The given jobtitle
    # @param [String] contact_sex Can be male, female or unknown
    # @param [String] proactive Can be yes or no
    # @param [String] letter With motivational letter? Can be yes or no
    # @param [String] name_of_pdf Name of the resulting PDF file
    # TODO: Try to fix this in future
    # This method smells of :reek:LongParameterList
    def self.result_ok(contact, email_address, job_title, contact_sex, proactive, letter, name_of_pdf, sysconf_dir,
                       data_dir, mail_backend, target)
      resultfile_ok = `yad --title="Resulting file" --center --on-top --form \
--item-separator=, --separator="|" \
--field="Resulting file ok?:CBE" \
"yes,no"`
      ok = resultfile_ok.chomp.split('|')
      if ok.include? 'yes'
        LatexCurriculumVitae::Email.create_email(contact, email_address, job_title, contact_sex, proactive, letter,
                                                 name_of_pdf, sysconf_dir, data_dir, mail_backend, target)
      else
        abort('Aborted')
      end
    end
  end
end
