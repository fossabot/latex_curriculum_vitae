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
require 'rainbow/ext/string'
require 'pony'
require 'resolv-replace.rb'
require File.expand_path(File.join(File.dirname(__FILE__), 'get-config'))

# rubocop:disable Metrics/LineLength
# Module for creating the CV
module LatexCurriculumVitae
  module Email
    # Method for creating the email
    # rubocop:disable Metrics/MethodLength
    # @param [String] contact Name of the contact
    # @param [String] emailaddress Email address of the contact
    # @param [String] jobtitle Title of the target job
    # @param [String] contact_sex Can be male, female or unknown
    # @param [String] proactive Can be yes or no
    # @param [String] letter For preparing the letter
    # @param [String] name_of_pdf Name of the output pdf
    def self.create_email(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf, sysconfdir,
                          datadir, mail_backend)
      own_email_address, own_smtp, own_username, own_password, own_port, own_tls = LatexCurriculumVitae::GetConfig.get_smtp(sysconfdir)
      introduction = LatexCurriculumVitae::Email.introduction(contact, contact_sex)
      subject = LatexCurriculumVitae::Email.subject(proactive, jobtitle)
      body = LatexCurriculumVitae::Email.get_body(introduction, letter)
      filename = "#{datadir}/#{name_of_pdf}.pdf"

      if mail_backend == 'Pony'
        # More information about Pony Mailer: https://github.com/benprew/pony
        Pony.mail(to: emailaddress,
                  bcc: own_email_address,
                  from: own_email_address,
                  subject: subject,
                  body: body,
                  attachments: { 'Bewerbungsunterlagen_Manns.pdf' => File.read(filename) },
                  via: :smtp,
                  via_options: {
                    address: own_smtp,
                    port: own_port,
                    enable_starttls_auto: own_tls,
                    user_name: own_username,
                    password: own_password,
                    authentication: :plain, # :plain, :login, :cram_md5, no auth by default
                    domain: 'localhost.localdomain', # the HELO domain provided by the client to the server
                  })
      else
        `evolution mailto:"#{emailaddress}?subject=#{subject}\&body=#{body}\&attach=#{filename}"`
      end
    end

    # Method for building the introduction
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Can be male, female or unknown
    # @return [String] Returns introductiion
    def self.introduction(contact, contact_sex)
      introduction = if contact == ''
                       'Sehr geehrte Damen und Herren,'
                     else
                       introduction = if contact_sex == 'male'
                                        "Sehr geehrter Herr #{contact},"
                                      else
                                        "Sehr geehrte Frau #{contact},"
                                      end
                     end
      return introduction
    end

    # Method for building the subject
    # @param [String] proactive Can be yes or no
    # @param [String] jobtitle Title of the target job
    # @return [String] subject Set the subject
    def self.subject(proactive, jobtitle)
      subject = if proactive == 'yes'
                  "Initiativbewerbung um einen Arbeitsplatz als #{jobtitle}"
                else
                  "Bewerbung um einen Arbeitsplatz als #{jobtitle}"
                end
      return subject
    end

    # Method for building the email body
    # @param [String] introduction EMail introduction
    # @param [String] letter With motivational letter? Can be yes or no
    # @return [String] body Returns the messagebody for the email
    def self.get_body(introduction, letter)
      body = if letter == 'no'
               <<EOF
#{introduction}
Wie ich Ihrer Anzeige entnommen habe, suchen Sie jemanden für die obige Position, um
die ich mich bewerbe. Mit meinen vielfältigen Erfahrungen als Kaufmann, Community Ma-
nager, Buchautor und Customer Supporter (Level 1&2), sowie Autor Geschäftsprozess- &
Anwendungsdokumentation könnte ich Ihr neuer Mitarbeiter sein.
Seit dieser Zeit habe ich an teamgesteuerten Projekten für Kunden mitgearbeitet, wo-
bei mein Schwerpunkt im Bereich Kundenpflege via Telefon und Email, Dispatching und
Teamcontrolling lag.
In für mich fremde Arbeitsgebiete werde ich mich rasch einarbeiten.
Meine Kenntnisse in IT und Organisationsfähigkeiten kann ich für Ihr Unternehmen im
Bereich des Managements gewinnbringend umsetzen.
Persönlich runde ich das Profil mit den Eigenschaften: Teamfähigkeit, Kommunikations-
stärke und Leistungsbereitschaft ab.
Ich bin mir sicher, die von Ihnen gewünschten Kenntnisse und Fähigkeiten mitzubringen,
und würde mich sehr über ein Vorstellungsgespräch freuen.
--
Sincerly yours

Sascha Manns
Maifeldstraße 10
56727 Mayen
Phone: +49-1573-9242730 (mobile)
Phone: +49-2651-4014045 (home)
Email: Sascha.Manns@mailbox.org
Web: http://saigkill.tuxfamily.org
EOF
             else
               <<EOF
#{introduction}
gerne möchte ich mich bei Ihnen für die obige Stelle bewerben.
Meine digitale Bewerbungsmappe, samt des offiziellen Anschreibens, sind der Mail als Anhang beigefügt.
--
Sincerly yours

Sascha Manns
Maifeldstraße 10
56727 Mayen
Phone: +49-1573-9242730 (mobile)
Phone: +49-2651-4014045 (home)
Email: Sascha.Manns@mailbox.org
Web: http://saigkill.tuxfamily.org
EOF
             end
      return body
    end

    # Method for checking the result
    # @param [String] contact Name of the contact
    # @param [String] emailaddress Email address from the contact
    # @param [String] jobtitle The given jobtitle
    # @param [String] contact_sex Can be male, female or unknown
    # @param [String] proactive Can be yes or no
    # @param [String] letter With motivational letter? Can be yes or no
    # @param [String] name_of_pdf Name of the resulting PDF file
    def self.result_ok(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf, sysconfdir,
                      datadir, mail_backend)
      resultfileok = `yad --title="Resulting file" --center --on-top --form \
--item-separator=, --separator="|" \
--field="Resulting file ok?:CBE" \
"yes,no"`
      ok = resultfileok.chomp.split('|')
      if ok.include? 'yes'
        LatexCurriculumVitae::Email.create_email(contact, emailaddress, jobtitle, contact_sex, proactive, letter,
                                                 name_of_pdf, sysconfdir, datadir, mail_backend)
      else
        abort('Aborted')
      end
    end
  end
end
