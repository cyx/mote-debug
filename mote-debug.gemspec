Gem::Specification.new do |s|
  s.name              = "mote-debug"
  s.version           = "0.0.1"
  s.summary           = "Mote debug aid."
  s.description       = "Minimal debugging support for mote."
  s.authors           = ["Cyril David"]
  s.email             = ["me@cyrildavid.com"]
  s.homepage          = "http://github.com/cyx/mote-debug"

  s.files = Dir[
    "LICENSE",
    "README",
    "rakefile",
    "lib/**/*.rb",
    "*.gemspec",
    "test/*.*"
  ]

  s.add_dependency "mote", "~> 0.2.4"
  s.add_development_dependency "dep"
  s.add_development_dependency "cutest"
end
