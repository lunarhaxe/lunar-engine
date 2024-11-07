> [!IMPORTANT]
> Vortex is being discontinued in favor of **zina.hx**, a simple graphics and audio API for Haxe.
> 
> It will be kept publicly archived for people who may still want to
> give Vortex a try, or atleast to look at it's code.
> 
> You can find zina.hx on this same organization [here](https://github.com/zina-framework/zina.hx)!

<img src="https://avatars.githubusercontent.com/u/146598504" alt="Vortex Engine Logo" align="right" width="200" height="200" />

# Vortex
A 2D Game Framework made in Haxe built for simplicity and performance.

## 🖥️ Platforms
Vortex natively can run on Windows, MacOS and Linux systems via `hxcpp`.
MacOS support is currently untested.

## 💡 Getting Started
In order to start using Vortex, start by installing the haxelib:

### ⚡ Development Installation
This will install the very latest, potentially unstable version of Vortex.
```sh
haxelib git vortex https://github.com/vortex-haxe/vortex
```

On Linux, you will need to run some commands for Vortex to run correctly.

The commands depend on your distro, if it isn't on this list here, look it up and/or make a pull request to this README.

Here is a list of each command needed:

## 🐌 Debian/Ubuntu
```
sudo apt install g++
sudo apt install libsdl2-dev -y
sudo apt install libopengl-dev -y
sudo apt install libopenal-dev -y
```

## ⚡ Arch Linux
```
sudo pacman -S gcc
sudo pacman -S sdl2
sudo pacman -S mesa
sudo pacman -S openal
```

## 📔 Libraries
Here are the puzzle pieces that are put together to make Vortex possible!

<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Simple_DirectMedia_Layer%2C_Logo.svg/1280px-Simple_DirectMedia_Layer%2C_Logo.svg.png" alt="SDL Logo" align="right" width="62" height="32" />

### [hxsdl](https://github.com/swordcube/hxsdl)

SDL Bindings for Haxe, used for making a window and having window events.

### [hxstb_image](https://github.com/swordcube/hxstb_image)
STB Image Bindings for Haxe, used for loading image files.

<img src="https://upload.wikimedia.org/wikipedia/commons/e/e9/Opengl-logo.svg" alt="OpenGL Logo" align="right" width="62" height="32" />

### [hxglad](https://github.com/swordcube/hxglad)
GLAD Bindings for Haxe, used for rendering to the window with OpenGL.

### [hxdr_mp3](https://github.com/swordcube/hxdr_mp3)
Dr MP3 Bindings for Haxe, used for loading MP3 files.

### [hxdr_wav](https://github.com/swordcube/hxdr_wav)
Dr WAV Bindings for Haxe, used for loading WAV files.

### [hxstb_vorbis](https://github.com/swordcube/hxstb_vorbis)
STB Vorbis Bindings for Haxe, used for loading OGG files.

<img src="https://upload.wikimedia.org/wikipedia/en/thumb/1/1f/OpenAL_logo.svg/1280px-OpenAL_logo.svg.png" alt="OpenAL Logo" align="right" width="70" height="32" />

### [hxal](https://github.com/swordcube/hxal)
OpenAL Soft Bindings for Haxe, used for playing audio.
