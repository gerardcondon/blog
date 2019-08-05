---
title: "Python and Midi"
date: 2019-08-05 08:00
tags: music
keywords: python, midi
---

Following on from getting midi working on my pc, I wanted to look at programming options for it.
Python seemed a decent candidate to start with - a scripting language with a sizable community, so there was bound to be existing libraries for it.
I found [python-rtmidi](http://trac.chrisarndt.de/code/wiki/python-rtmidi) and decided to give it a go. It installs the C++ RtMidi classes and a Python wrapper around them.

I initially installed it into my WSL installation of Ubuntu. 
However that didn't work - it couldn't see the native Windows midi device drivers.
There is probably a way to fix that but I didn't want to waste much time on it until I has proven that the Python/Midi combo worked at all on Windows.

So I installed Python natively on Windows along with Pip.
After installing the python-rtmidi package I ran some of the test scripts and it worked straight away.
It was able to send sounds to the keyboard to play and also read from the keyboard what keys were being pressed.
It was good fun and would seem to me to be a great way to introduce kids who are musically inclined to programming.
