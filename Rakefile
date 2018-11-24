# -*- ruby -*-
# Copyright (C) 2013-2018 Sascha Manns <Sascha.Manns@outlook.de>
# Release:
# Pre-release:
#* update docs
#* Update copyright years if needed, in the following paths:
#  + lib/*
#* Check version in lib/hoe-reek.rb
#* Update CHANGELOG.md & NEWS
#* git:manifest
#* bundler:gemfile
#* bundler:gemfile_lock
# x64-mingw32
# x64-mswin32
# x86-mingw32
# x86-mswin32
# ruby
# x86_64-linux
#* bundle_audit:run
#* git -a -m "Anything"
#* git tag x.x.x

# Release:
#* Create Release in Github
#* rake release
#* send_email
#* clean_pkg

# Post-release:
#* Bump version
#* Add new Milestone on Github
###################################### SETUP ZONE #####################################################################

require 'fileutils'
require 'xdg'
desc 'Setup'
task :setup do
  sys_xdg = XDG['CONFIG_HOME']
  data_xdg = XDG['DATA_HOME']
  sysconf_dir = "#{sys_xdg}/latex_curriculum_vitae"
  data_dir = "#{data_xdg}/latex_curriculum_vitae"
  home = Dir.home
  FileUtils.mkdir(sysconf_dir) if !File.exist?(sysconf_dir)
  FileUtils.mkdir(data_dir) if !File.exist?(data_dir)
  FileUtils.cp('etc/latex_curriculum_vitae.cfg', "#{sysconf_dir}") if !File.exist?
  ("#{sysconf_dir}/latex_curriculum_vitae.cfg")
  FileUtils.cp('etc/personal_data.tex', "#{sysconf_dir}") if !File.exist?("#{sysconf_dir}/personal_data.tex")
  FileUtils.cp_r('data/latex_curriculum_vitae/.', "#{data_dir}") if !File.exist?("#{data_dir}/Appendix")
  puts 'Setup is now finished. See the documentation to find out more about this gem.'
end

# vim: syntax=ruby
