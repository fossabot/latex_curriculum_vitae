# -*- ruby -*-
# Release:
# * update *.wiki markdown documentation for GitLab
# * enable :git
# * rake run_before_release
# * disable :git
# * Checkin
# * rake release
# * rake run_after_release

require 'rubygems'
require 'hoe'

# rubocop:disable Metrics/LineLength
############################################# DEVELOPING ZONE #########################################################
Hoe.plugin :bundler
# Hoe.plugin :deveiate
Hoe.plugin :doofus
Hoe.plugin :email
# Hoe.plugin :gem_prelude_sucks
#Hoe.plugins.delete :git
Hoe.plugin :git
Hoe.plugin :history
Hoe.plugin :highline
#Hoe.plugin :inline
Hoe.plugin :manns
# Hoe.plugin :mercurial
# Hoe.plugin :perforce
# Hoe.plugin :racc
# Hoe.plugin :rcov
#Hoe.plugin :reek
Hoe.plugin :rdoc
Hoe.plugin :rubocop
Hoe.plugin :rubygems
# Hoe.plugin :seattlerb
Hoe.plugin :version
Hoe.plugin :website

Hoe.spec 'latex_curriculum_vitae' do
  developer('Sascha Manns', 'Sascha.Manns@mailbox.org')
  license 'MIT' # this should match the license in the README
  require_ruby_version '>= 2.2.0'

  email_to << 'ruby-talk@ruby-lang.org'
  email_to << 'TEX-D-L@LISTSERV.DFN.DE'

  self.history_file = 'History.rdoc'
  self.readme_file = 'README.rdoc'
  self.extra_rdoc_files = FileList['*.rdoc'].to_a
  self.post_install_message = '*** Run rake setup to finish the installation *** Please file bugreports and feature requests on: https://github.com/saigkill/latex_curriculum_vitae/issues'

  dependency 'setup', '~> 5.2'
  dependency 'notifier', '~> 0.5'
  dependency 'pony', '~> 1.11'
  dependency 'combine_pdf', '~> 0.2'
  dependency 'url_shortener', '~> 0.0.9'

  extra_dev_deps << ['hoe-bundler', '~> 1.3']
  extra_dev_deps << ['hoe-doofus', '~> 1.0']
  extra_dev_deps << ['hoe-git', '~> 1.6']
  extra_dev_deps << ['hoe-rubygems', '~> 1.0']
  extra_dev_deps << ['hoe-manns', '~> 1.5']
  extra_dev_deps << ['hoe-reek', '~> 1.1']
  extra_dev_deps << ['hoe-rubocop', '~> 1.0']
  extra_dev_deps << ['hoe-version', '~> 1.2']
  extra_dev_deps << ['hoe-seattlerb', '~> 1.3']
  extra_dev_deps << ['hoe', '~> 3.15']
  extra_dev_deps << ['rake', '~> 11.2']
  extra_dev_deps << ['simplecov', '~> 0.12']
  extra_dev_deps << ['coveralls', '~> 0.8']
  extra_dev_deps << ['rainbow', '~> 2.0']
  extra_dev_deps << ['bundler', '~> 1.11']
  extra_dev_deps << ['parseconfig', '~> 1.0']
  extra_dev_deps << ['rspec', '~> 3.5']
  extra_dev_deps << ['simplecov', '~> 0.10']
end

###################################### SETUP ZONE #####################################################################

require 'fileutils'
desc 'Setup'
task :setup do
  datadir = "#{Dir.home}/.rvm/rubies/default/share"
  FileUtils.cp("#{Dir.home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg",
               "#{Dir.home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg.my")
  FileUtils.cp("#{Dir.home}/.latex_curriculum_vitae/personal_data.tex", "#{Dir.home}/.latex_curriculum_vitae/personal_data.tex.my")
  FileUtils.mkdir("#{datadir}/latex_curriculum_vitae-backup") if !File.exist?("#{datadir}/latex_curriculum_vitae-backup")
  FileUtils.cp_r "#{datadir}/latex_curriculum_vitae/.", "#{datadir}/latex_curriculum_vitae-backup/." if
                File.exist?("#{datadir}/latex_curriculum_vitae/")
  system('setup.rb uninstall --force')
  system('setup.rb config --sysconfdir=$HOME/.latex_curriculum_vitae')
  system('setup.rb install')
  FileUtils.cp("#{Dir.home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg.my",
               "#{Dir.home}/.latex_curriculum_vitae/latex_curriculum_vitae.cfg")
  FileUtils.cp("#{Dir.home}/.latex_curriculum_vitae/personal_data.tex.my", "#{Dir.home}/.latex_curriculum_vitae/personal_data.tex")
  puts 'Creating Launcher...'.color(:yellow)
  desktopfile = "#{Dir.home}/.local/share/applications/latex_curriculum_vitae.desktop"
  FileUtils.touch(desktopfile)
  File.write "#{desktopfile}", <<EOF
[Desktop Entry]
Version=2.3
Type=Application
Name=latex_curriculum_vitae
GenericName=latex_curriculum_vitae
Comment=Job-Application Creator
Exec=latexcv.rb
Icon="#{Dir.home}/.local/share/icons/arbeitsagentur.png"
Categories=Utility;Application;
EOF
  puts 'Setup is now finished. See the documentation to find out more about this gem.'

end

# vim: syntax=ruby
