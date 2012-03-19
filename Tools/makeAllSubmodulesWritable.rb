#!/usr/bin/env ruby -wKU
# encoding: utf-8


glibdir = "../Modules"
Dir.chdir glibdir             # change to libdir so that requires work
glibdir = Dir.pwd

$main_repository = true
require "#{glibdir}/Support/jamomalib"


def doOne submoduleName
  quietly do
    ARGV[0] = "#{submoduleName}"
  end  
  puts "changing permission for #{submoduleName}"
  load "../Tools/makeSubmoduleWritable.rb"      
end
                     
doOne "AudioGraph"
doOne "Dependencies"
doOne "Documentation"
doOne "DSP"
doOne "Foundation"
doOne "Graph"
doOne "Graphics"
doOne "Modular"
doOne "Plugtastic"
doOne "Ruby"
doOne "Test"
doOne "Support"              

