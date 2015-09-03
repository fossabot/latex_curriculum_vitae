# rubocop:disable Style/FileName
# rubocop:disable Metrics/LineLength
require File.expand_path(File.join(File.dirname(__FILE__), 'lib', 'latex_curriculum_vitae/version.rb'))

Gem::Specification.new do |spec|
  spec.name = 'LatexCurriculumVitae'
  spec.version = LatexCurriculumVitae::Version::STRING
  spec.authors = 'Sascha Manns'
  spec.email = 'samannsml@directbox.com'

  spec.summary = ['A program for creating an application']
  spec.description = 'It supports creating a application by rendering with LaTEX.'

  spec.homepage = 'https://github.com/saigkill/latex_curriculum_vitae'
  spec.license = 'GPL-3'
  spec.metadata = { 'issue_tracker' => 'http://saigkill-bugs.myjetbrains.com/youtrack/issues' }

  spec.files = `git ls-files -z`.split("\x0").reject { |f|
    f.match(%r{^(test|spec|features)/})
  }
  spec.bindir = 'bin'
  spec.executables = spec.files.grep(%w(latexcv)) { |f|
    File.basename(f)
  }
  spec.require_paths = ['lib']
  spec.post_install_message = 'Please file bugreports and feature requests on: http://saigkill-bugs.myjetbrains.com/youtrack/issues'

  spec.platform = Gem::Platform::RUBY
  spec.date = ENV['from'] ? Date.parse(ENV['from']) : Date.today
  spec.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")

  spec.add_development_dependency 'bundler', '~> 1.9', '>= 1.9.6'
  spec.add_development_dependency 'rake', '~> 10.4', '>= 10.4.2'
  spec.add_development_dependency 'rdoc', '~> 4.2', '>= 4.2.0'
  spec.add_development_dependency 'yard', '~> 0.8', '>= 0.8.7.6'
  spec.add_development_dependency 'gem-release', '~> 0.7', '>= 0.7.3'
  spec.add_development_dependency 'rspec', '~> 3.2', '>= 3.2.0'
  spec.add_development_dependency 'simplecov', '~> 0.10', '>= 0.10.0'
  spec.add_development_dependency 'ruby-lint', '~> 2.0', '>= 2.0.4'
  spec.add_development_dependency 'bundler-audit', '~> 0.4', '>= 0.4.0'

  # spec.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.6.2'
  # spec.add_runtime_dependency 'parseconfig', '~> 1.0', '>= 1.0.6'
  # spec.add_runtime_dependency 'rainbow', '~> 2.0', '>= 2.0.0'
  # spec.add_runtime_dependency 'MannsShared', '~> 0.1', '>= 0.1.8'
  spec.add_runtime_dependency 'setup', '~> 5.2', '>= 5.2.0'
end