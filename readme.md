- [Download](#download)
- [Checking out](#checking-out)
- [Updating submodules](#updating-submodules)
- [Building the source code](#building)
- [Automatically update modules & build sources](#automatic-update-and-build)
- [Building the API documentation with Doxygen](#doxygen)

[Jamoma](http://www.jamoma.org) is a set of libraries for live (real-time) processing of multi-media. This repository is the master project for the Jamoma platform, and contains several submodules:

- Core : A set of layered C++ frameworks and extensions for creating an object model. This object model is then further specialized for advanced purposes such as audio.
- Documentation : Files required to compile [Doxygen](http://api.jamoma.org/) documentation as well as more implementation-specific documentation.
- Implementations : Submodules for implementing Jamoma in various hosting environments, such as iOS, Cycling'74 Max, PureData and Ruby. Of these, the Max implementation is by far the most complete and elaborated one.

The Tools folder contains a number of Ruby scripts simplifiying various common tasks for the development of Jamoma.

<a name="download"/>
#Download Jamoma

If you just want to download and use Jamoma with [Cycling'74 Max](http://www.cycling74.com), you can find the latest version at the main [Jamoma website](http://www.jamoma.org/download). The Jamoma UserLibs, which contains various development projects by Jamoma users, can be downloaded the same place. The source code for UserLibs can be retrieved as a [GitHub repository](https://github.com/jamoma/JamomaUserLibraries).


<a name="checking-out"/>
#Checking out the source code

In order to download and use the source code, you first need to ensure that you have [Git](http://git-scm.com/) and [Ruby](http://ruby.about.com/od/tutorials/a/installruby.htm) installed.

Start out by cloning this repository:

    git clone https://github.com/jamoma/Jamoma.git
    
Next you need to retrieve all submodules:

    cd  Jamoma
    git submodule update --init
    git checkout dev
    git pull
    git submodule update

This will bring you into "no branch" of the submodules, so you'll need to check them out to the desired branches, e.g.:

    cd Core
    git checkout dev
    cd ../Implementations/Max
    git checkout dev

If you want to checkout a specific branch for all submodules, you can run the following command, e.g. branch "dev" :     
        
    Git submodule foreach git checkout dev

<a name="updating-submodules"/>
##Update submodules

All sources needed to build Jamoma can be updated to last version following these steps:

1. From Terminal or the cygwin window (on Windows), go to the main Jamoma directory by running the following command :

    cd Jamoma

2. Run the following commands for the dev branch of all submodules :

    Git pull
    Git submodule foreach git pull


<a name="building"/>
##Building the source code

The Jamoma framework can be easily compiled using a Ruby script. To do so, please follow these steps:

1. From Terminal or the cygwin window (on Windows), go to the the main Jamoma directory by running the following command :

    cd Jamoma

2. Run the Ruby "build.rb" script running the following command:

    ruby build.rb Deployment clean

Alternatively, if you want a developer build rather than a distributable release version, you may do it so with the following command:

    ruby build.rb Development


<a name="doxygen"/>
##Building the API documentation with Doxygen

The API that documents our C++ source code is generated by [Doxygen](http://www.stack.nl/~dimitri/doxygen/index.html). A configuration file is included in this repository ([Jamoma_doxyfile.txt](https://github.com/jamoma/JamomaDoc/blob/master/Doxygen/Jamoma_doxyfile.txt)) that can easily be used with the GUI front-end available on the Doxygen website. When it is run, it will search source files in both the [Core](https://github.com/jamoma/JamomaCore) (../Core/) and [Implementations](https://github.com/jamoma/Jamoma/tree/master/Implementations) (../Implementations/) repositories for formatted comments found in individual files. These are then rendered as HTML in a new build folder (Doxygen/build/). It is STRONGLY advised that you delete this folder between attempts to render the content.

For more information on Doxygen, visit:
[http://www.stack.nl/~dimitri/doxygen/index.html](http://www.stack.nl/~dimitri/doxygen/index.html)

#Contributing

If you want to contribute to the development of Jamoma, the recommended workflow is described [here](contributing.md).

[ ![Codeship Status for jamoma/Jamoma](https://www.codeship.io/projects/316a6450-84e8-0131-c9aa-72135dc94a10/status?branch=master)](https://www.codeship.io/projects/15081)
