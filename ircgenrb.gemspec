require "version"
Gem::Specification.new do |s|
  s.name            = 'ircdgen'
  s.version         = Application.VERSION
  s.date            = '2016'
  s.summary         = "IRCd Configuration files generator"
  s.description     = <<-EOF
A small executable only application that generates IRCd Configuration files
EOF
  s.authors         = ["Ken Spencer"]
  s.email           = 'iota@electrocode.net'
  s.require_path    = "lib"
  s.executables     = "ircdgen.rb"
  s.files           = `git ls-files -z`.split("\x0")
  s.homepage        = 'http://electrocode.net/ircgenrb'
  s.license         = 'MIT'
end
