# Qian

> Qian is an hackable **micro File explorer** for **OSX**, written in **Elm** and
> **Electron**. The name **Qian** come from the name of
> [Zhang Qian](https://en.wikipedia.org/wiki/Zhang_Qian), a Chinese
> explorer. (aha get it ?)


### Summary

- [Tl;dr](#tldr)
- [Philosophy](#philosophy)
- [Features](#features)
- [Plans](#plans)
- [Credits](#credits)

## Tl;dr


![A tiny gif](http://full.ouplo.com/11/2e/DVAQ.gif)


Since I'm on Mac, I mainly use the terminal to navigate my files because
I do not like much Finder (I don't really have any arguments ...).
So I decided to build a small file explorer (mainly to navigate my documents)
that would fit perfectly to **my needs**.

I used **Elm** because I wanted to learn how to use it, and **Electron**
because I want to prototype quickly.

## Philosophy

The main goal of this project is not to create a revolutionary software.
Just build a useful software for me. The idea is to implement features only
**when I need them**.

If you see any changes to the code, do not hesitate to make an issue or pull-request!
In addition, if a feature seems interesting to implement, let's talk about it in an issue!

## Features

**Qian** supports the mouse and some key shortcuts.

- `Tab` toggle the focus on the searchbar
- `Enter` open the first folder (if the searchbar is active and filled)
- `Alt + Enter` open the current directory in a terminal
- `Alt + Shift + Enter` open the current directory in Finder
- `Alt + Uparrow` go to the parent folder
- `Alt + LeftArrow` go to the previous folder (History)
- `Alt + RightArrow` go to the next folder (History)
- `Alt + W` toggle the display of hidden files

## Usage

-  `make install` to fetch the NPM dependancies
-  `make build` to build the application
-  `make run` to run the buildt application
-  `make` (a combo of `make build` and `make run`)

## Plans

A Non exhaustive list of desired features

-  [ ] Package the application
-  [ ] Improve the UI/UX
-  [ ] Add a global search mode
-  [ ] Add the capability of create/delete/rename/move/cp files
-  [ ] Improve the key shortcuts

## Credits

-  [Elm](http://elm-lang.org/) (to have a nice language)
-  [Electron](https://electron.atom.io/) (to have a window !)
-  [Font Awesome](http://fontawesome.io/) (for the icon in the UI)
