#!/usr/bin/env ruby -wKU

# First include the functions in the jamoma lib
glibdir = "."
Dir.chdir glibdir             # change to libdir so that requires work
glibdir = Dir.pwd
require "supports/jamomalib"


###################################################################
# Check Args
###################################################################

if(ARGV.length == 0)
  puts "usage: "
  puts "ruby tag.rb <required:tag-name>"
  exit 0;
end

$tag = ARGV[0];


def tagOne name

  puts "tagging #{name}"
  `cd ../Modules/#{name}; git remote prune origin`
  `cd ../Modules/#{name}; git tag #{$tag}`
  `cd ../Modules/#{name}; git push origin --tags`

end

`git remote prune origin`
`git tag #{$tag}`
`git push origin --tags`

tagOne "Foundation"
tagOne "DSP"
tagOne "Graphics"
tagOne "Multicore"
tagOne "Modular"

#{}`git submodule foreach git remote prune origin`
#{}`git submodule foreach git tag #{tag}`
#{}`git submodule foreach git push origin --tags`