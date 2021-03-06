[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsaigkill%2Flatex_curriculum_vitae.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsaigkill%2Flatex_curriculum_vitae?ref=badge_shield)

= latex_curriculum_vitae

== DESCRIPTION:

latex_curriculum_vitae is a Rubygem which help you to write your job applications. The program aks you for all relevant data for compiling
the curriculum vitae. It builds the motivational letter (if chosen in the gui), the cover and the cv. The resulting pdf will be found
in your home directory. Also it generates an email with a standard content, which allows you to send the mail with your cv directly.

The History.rdoc contains a detailed description on what has changed. For most
users the NEWS file might be a better place to look since it contains
change summaries between the different versions.

latex_curriculum_vitae is released under the GPL3 License, see the file 'License.rdoc'
for more information.

The official web site is:

    https://dev.azure.com/saigkill/latex_curriculum_vitae

|What| Where |
|----|-------|
| code | https://github.com/saigkill/latex_curriculum_vitae |
| docs | https://saschamanns.de/doc-lcv |
| apidoc | http://www.rubydoc.info/gems/latex_curriculum_vitae |
|bugs  | https://github.com/saigkill/latex_curriculum_vitae/issues |
|mailinglist | https://groups.google.com/forum/#!forum/latex_curriculum_vitae |
| openhub statistics | https://www.openhub.net/p/latex_curriculum_vitae |
| authors blog | http://saschamanns.de |
|min. rubyver | 2.3.0 |

| What | Status |
|------|--------|
|last public version  | {<img src="https://badge.fury.io/rb/latex_curriculum_vitae.png" alt="Build Status" />}[http://rubygems.org/gems/latex_curriculum_vitae] |
|downloads latest | {<img src="https://img.shields.io/gem/dtv/latex_curriculum_vitae.svg" alt="Build Status" />}[http://rubygems.org/gems/latex_curriculum_vitae]|
|downloads all | {<img src="https://img.shields.io/gem/dt/latex_curriculum_vitae.svg" alt="Build Status" />}[http://rubygems.org/gems/latex_curriculum_vitae] |
|code quality | {<img src="https://scrutinizer-ci.com/g/saigkill/latex_curriculum_vitae/badges/quality-score.png?b=master" />}[https://scrutinizer-ci.com/g/saigkill/latex_curriculum_vitae/] |
|code quality | {<img src="https://api.codeclimate.com/v1/badges/58bdf05db541e741c5d3/maintainability" alt="Code Quality" />}[https://codeclimate.com/github/saigkill/latex_curriculum_vitae] |
|security | {<img src="https://hakiri.io/github/saigkill/latex_curriculum_vitae/master.svg" alt="security" />}[https://hakiri.io/github/saigkill/latex_curriculum_vitae/master] |
|documentation quality | {<img src="http://inch-ci.org/github/saigkill/latex_curriculum_vitae.svg?branch=master" alt="Documentation Quality" />}[http://inch-ci.org/github/saigkill/latex_curriculum_vitae] |

== FEATURES:

* Ruby based LaTEX publisher for job applications
* It use Pony and Evolution for sending the email directly

== SYNOPSIS:

  $ latexcv.rb

  Or just use the Launcher.

The resulting PDF and the CSV file are placed in /home/You/.local/latex_curriculum_vitae.

This Gem was programmed and tested for Linux systems. If anyone would like to make the methods also fit for other OS,
i'm happy about Pull requests.

== REQUIREMENTS:

* setup
* notifier
* pony
* combine_pdf
* url_shortener

== REQUIREMENTS (hard dependencies):

* pdflatex & xelatex
* yad
* poppler (pdfunite)

== INSTALL:

The installation is very easy.

    gem install latex_curriculum_vitae
    cd /path/to/gem (In case of using RVM ~/.rvm/gems/ruby-2.2.3/gems/latex_curriculum_vitae)
    rake setup

You have to run the setup after each gem update.

== DEVELOPERS:

After checking out the source, run:

  $ rake newb

This task will install any missing dependencies, run the tests/specs,
and generate the RDoc.

## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fsaigkill%2Flatex_curriculum_vitae.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fsaigkill%2Flatex_curriculum_vitae?ref=badge_large)