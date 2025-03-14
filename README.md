Cortex Command Community Project - open source under GNU AGPL v3

This is a community-driven effort to continue the development of Cortex Command

# CONTACT #

https://discord.gg/junGCWe


# Known problems and limitations #

Tested to build only with Visual Studio 2017 for Win32 platform with Visual Studio 2013 toolset installed (You may need to install full VS 2013).

Almost builds with modern toolchains in VS 2017 and VS 2019, but there's some incompatibility in Luabind which fails to compile. Other than that should be fine.

The Linux build with gcc only got tested on 64 bit Linux.

Included source code does not match the current B32 functionality. This is a work-in-progress snapshot of what's internally called "B33", so it won't start with data from B32.

No game data and most of required runtime DLLs are included, you should get those from the Cortex Command beta branch on Steam.

Commercial fmod library was replaced with free SDL Mixer which lacks pitching functionality hence some sound effects will sound differently or incorrectly.

All source and binary dependencies required to build the project are included.

This version uses a slightly modified version of Allegro. The only difference from the original is a custom window borderless mode implemented to fix fullscreen issues. If you're gonna rebuild Allegro you'l probably need to disable custom calls in FrameMan.


# BUILD PROCESS #

## Windows


Use Debug Open Source configuration to debug (be prepared, it's very slow).

Use Final Open Source configuration to build release .exe.

Binaries go to _Bin, you can't run from there outside of the IDE, it won't find required stuff.

You need to copy SDL related dlls from external\lib\win\ next to .exe in order to run it.

The data can be found under the "ccoss" beta branch of Cortex Command on Steam, if you own a license for the game.


## Linux

You also have to compile the [dependencies](https://github.com/liberated-cortex/CCOSS_dependencies.git):

```
git clone https://github.com/liberated-cortex/CCOSS_dependencies.git
git clone https://github.com/liberated-cortex/CCOSS.git
cd CCOSS_dependencies
./prepare.sh
cd ../CCOSS
make all PREPARED_DIR=../CCOSS_dependencies/prepared/ -j4
```

The executable `cortex` must be run from the main directory of your game content, copying the executable to that directory also works.

Combined with building [blackCortex](https://github.com/liberated-cortex/blackCortex.git) this would look like this:

```
git clone --recursive https://github.com/liberated-cortex/blackCortex.git
cd ./blackCortex/
make
../CCOSS/cortex
```

*blackCortex is not in a playable state yet*

If you don’t wanna use blackCortex, the data can be found under the "ccoss" beta branch of the Windows version of Cortex Command on Steam, if you own a license for the game.