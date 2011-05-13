#!/usr/bin/ruby -wKU

require "FileUtils"

glibdir = "."
Dir.chdir glibdir             # change to libdir so that requires work
glibdir = Dir.pwd

Dir.chdir "#{glibdir}/../.."

search = `ls -pRA | grep Modules/Graph/.*MaxMSP.*xcode`

xcodeProjs = Array::new
xcodeProjs = search.split(":\n")

created = 0

xcodeProjs.each do |proj|
  vcproj = proj.sub(/(.+)(.xcodeproj)/, '\1.vcproj')

	unless File.exist?("#{vcproj}")
		puts "CREATING MSVC PROJECT:  " + vcproj + "\n"
		`cp ./Modules/Graph/implementations/MaxMSP/op/jcom.op.vcproj #{vcproj}`
		created += 1
	end
end
puts "NOTHING TO DO!" if (created == 0)