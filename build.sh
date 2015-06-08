#!/bin/bash -x
set -euf -o pipefail
########################################
###### Intro & Parameter handling ######
########################################

JAMOMA_CMAKE_TOOLCHAIN=""
JAMOMA_CMAKE_BUILD_TYPE="-DCMAKE_BUILD_TYPE=Debug"

JAMOMA_CMAKE_UNIVERSAL_FLAGS=""
JAMOMA_ENABLE_MULTICORE=False

JAMOMA_CMAKE_MAX_FLAGS="-DBUILD_JAMOMAPD:bool=True"
JAMOMA_CMAKE_PD_FLAGS="-DBUILD_JAMOMAMAX:bool=True"

JAMOMA_INSTALL_JAMOMA=""
JAMOMA_UNINSTALL_JAMOMA=False


HELP_MESSAGE="Usage : $(basename "$0") [options]
Builds Jamoma

Options :
--no-jamoma-pd
  Does not build Jamoma PureData implementation.
--no-jamoma-max
  Does not build Jamoma Max implementation. Only effective on OS X (since there is no Max on Linux)
--multi
  Builds using all your cores.
--universal
  Builds an universal binary for OS X. Warning: does not work well with brew; portmidi and gecode have to be built by hand
--optimize
  Builds with optimizations enabled. More speed, but is not suitable for distribution on older computers or different processors.

--clean
  Removes the build folder and the executables prior to building.
--install
  Install in /usr/local/jamoma
--uninstall
  Removes /usr/local/jamoma

--help
  Shows this message
"

while test $# -gt 0
do
	case "$1" in
	--help) echo "$HELP_MESSAGE"
		exit
		;;
	--multi) echo "Will build using every logical core on the computer (faster)"
		JAMOMA_ENABLE_MULTICORE=True
		;;
	--optimize) echo "Optimized build"
		JAMOMA_CMAKE_BUILD_TYPE="-DCMAKE_BUILD_TYPE=Release"
		CFLAGS="-Ofast -march=native"
		CXXFLAGS="$CFLAGS"
		;;
	--universal) echo "Universal build (i386; x86_64)"
		JAMOMA_BREW_UNIVERSAL_FLAGS="--universal"
		JAMOMA_CMAKE_UNIVERSAL_FLAGS="-DCMAKE_OSX_ARCHITECTURES=x86_64;i386"
		;;
	--install) echo "Will uninstall Jamoma"
		JAMOMA_INSTALL_JAMOMA="install"
		;;

	--uninstall) echo "Will uninstall Jamoma"
		sudo rm -rf /usr/local/jamoma
		;;

	--no-jamoma-pd) echo "Will not install JamomaPd"
		JAMOMA_CMAKE_PD_FLAGS="-DBUILD_JAMOMAPD:bool=False"
		;;
	--no-jamoma-max) echo "Will not install JamomaMax"
		JAMOMA_CMAKE_MAX_FLAGS="-DBUILD_JAMOMAMAX:bool=False"
		;;

	--clean) echo "Removal of the build folder"
		rm -rf build
		;;
	*) echo "Wrong option : $1"
		echo "$HELP_MESSAGE"
		exit 1
		;;
	esac
	shift
done

if [[ "$JAMOMA_ENABLE_MULTICORE" == "True" ]]; then
	JAMOMA_NUM_THREADS=`sysctl -n hw.ncpu`
else
	JAMOMA_NUM_THREADS=1
fi


mkdir -p build
(
	cd build
	cmake "../../Jamoma" $JAMOMA_CMAKE_BUILD_TYPE $JAMOMA_CMAKE_UNIVERSAL_FLAGS $JAMOMA_CMAKE_MAX_FLAGS $JAMOMA_CMAKE_PD_FLAGS $JAMOMA_CMAKE_TOOLCHAIN
	make -j$JAMOMA_NUM_THREADS

	sudo make $JAMOMA_INSTALL_JAMOMA
)
