Gem::Specification.new do |s|
  s.name = 'hubmeme'
  s.version = '1.0.0'
  s.licenses = ['MIT']
  s.summary = 'How big a meme are you on GitHub?'
  s.description = <<DESC
HubMeme is a whimsical command-line tool to figure out how big a meme a user is
on GitHub. Meme-ness is calculated by summing over all repositories a user has
contributed to the product of their percentage contribution and the number of
stars the repository has.
DESC
  s.authors = ["Mat Brown"]
  s.email = 'mat.a.brown@gmail.com'
  s.files = ["bin/hubmeme", "lib/hubmeme.rb", "README.md", "LICENSE"]
  s.executables << 'hubmeme'
  s.homepage = 'http://github.com/outoftime/hubmeme'
  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'octokit'
end
