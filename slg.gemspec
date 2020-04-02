require "./lib/slg"

Gem::Specification.new do |s|
  s.name          = "slg"
  s.version       = Slg.version
  s.date          = Time.now

  s.summary       = "Slengo.it unofficial scrapper"
  s.description   = "Get words' definitions from Slengo on the command-line."
  s.license       = "MIT"

  s.author        = "Baptiste Fontaine"
  s.email         = "b@ptistefontaine.fr"
  s.homepage      = "https://github.com/bfontaine/slg"

  s.files         = ["lib/slg.rb"]
  s.test_files    = Dir.glob("tests/*tests.rb")
  s.require_path  = "lib"

  s.executables << "slg"

  s.add_runtime_dependency "defcli", "~> 0.0"
  s.add_runtime_dependency "nokogiri", "~> 1.10"

  s.add_development_dependency "simplecov", "~> 0.18"
  s.add_development_dependency "rake",      "~> 12.3"
  s.add_development_dependency "test-unit", "~> 3.3"
  s.add_development_dependency "webmock",   "~> 3.8"
  s.add_development_dependency "coveralls", "~> 0.8"
end
