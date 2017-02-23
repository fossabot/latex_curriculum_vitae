#!/usr/bin/env ruby
# encoding: utf-8
# @author Sascha Manns
# @abstract module for preparing a email and send it out
#
# Copyright (C) 2015-2017  Sascha Manns <Sascha.Manns@mailbox.org>
# License: MIT

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
    def self.create_email(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf)
      own_email_address, own_smtp, own_username, own_password, own_port, own_tls = LatexCurriculumVitae::GetConfig.get_smtp
      introduction = LatexCurriculumVitae::Email.introduction(contact, contact_sex)
      subject = LatexCurriculumVitae::Email.subject(proactive, jobtitle)
      body = LatexCurriculumVitae::Email.get_body(introduction, letter)
      home = Dir.home
      filename = "#{home}/.latex_curriculum_vitae/#{name_of_pdf}.pdf"

      Pony.mail({
                    :to => emailaddress,
                    :bcc => own_email_address,
                    :from => own_email_address,
                    :subject => subject,
                    :body => body,
                    :attachments => {'Bewerbungsunterlagen_Manns.pdf' => File.read(filename)},
                    :via => :smtp,
                    :via_options => {
                        :address => own_smtp,
                        :port => own_port,
                        :enable_starttls_auto => true,
                        :user_name => own_username,
                        :password => own_password,
                        :authentication => :plain, # :plain, :login, :cram_md5, no auth by default
                        :domain => 'localhost.localdomain', # the HELO domain provided by the client to the server
                    }
                })
    end

    # Method for building the introduction
    # @param [String] contact Name of the contact
    # @param [String] contact_sex Can be male, female or unknown
    # @return [String] Returns introductiion
    def self.introduction(contact, contact_sex)
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

    # Method for building the subject
    # @param [String] proactive Can be yes or no
    # @param [String] jobtitle Title of the target job
    # @return [String] subject Set the subject
    def self.subject(proactive, jobtitle)
      if proactive == 'yes'
        subject = "Initiativbewerbung um einen Arbeitsplatz als #{jobtitle}"
      else
        subject = "Bewerbung um einen Arbeitsplatz als #{jobtitle}"
      end
      return subject
    end

    # Method for building the email body
    # @param [String] introduction EMail introduction
    # @param [String] letter With motivational letter? Can be yes or no
    # @return [String] body Returns the messagebody for the email
    def self.get_body(introduction, letter)
      # rubocop:disable Style/MultilineOperationIndentation
      if letter == 'no'
        body =<<EOF
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
Jabber: saigkill@jabber.org
Web: http://saigkill.github.io
Linkedin/Twitter: saigkill
Facebook: sascha.manns / Xing: Sascha_Manns2
GPG: 645A18FC6B573A7BE6E95150752763E8BFA83A2C @ hkp://keys.gnupg.net
S/MIME: C57921ED8F7535B08DC6D14BF11CD19BF9E8ED5C @ cacert.org
EOF
      else
        body =<<EOF
#{introduction}
gerne möchte ich mich bei Ihnen für die obige Stelle bewerben.
Meine Bewerbungsunterlagen samt des offiziellen Anschreibens sind der Mail als Anhang beigefügt.
--
Sincerly yours

Sascha Manns
Maifeldstraße 10
56727 Mayen
Phone: +49-1573-9242730 (mobile)
Phone: +49-2651-4014045 (home)
Email: Sascha.Manns@mailbox.org
Jabber: saigkill@jabber.org
Web: http://saigkill.github.io
Linkedin/Twitter: saigkill
Facebook: sascha.manns / Xing: Sascha_Manns2
GPG: 645A18FC6B573A7BE6E95150752763E8BFA83A2C @ hkp://keys.gnupg.net
S/MIME: C57921ED8F7535B08DC6D14BF11CD19BF9E8ED5C @ cacert.org
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
    def self.resultok(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf)
      resultfileok = `yad --title="Resulting file" --center --on-top --form \
--item-separator=, --separator="|" \
--field="Resulting file ok?:CBE" \
"yes,no"`
      ok = resultfileok.chomp.split('|')
      if ok.include? 'yes'
        LatexCurriculumVitae::Email.create_email(contact, emailaddress, jobtitle, contact_sex, proactive, letter, name_of_pdf)
      else
        abort('Aborted')
      end
    end
  end
end
