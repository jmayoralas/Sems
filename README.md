# Sems

This a personal project oriented to learn to code in Swift.

The target is to create a working ZX Spectrum emulator for Mac OS X.

## Current state

Right now, the emulator works with a vast majority of spectrum games and programs. It supports TAP and TZX tape formats. Instant load is available when using TAP files. TZX files with standard loaders are also supported in this mode.

## Known bugs

There are some known timings related bugs in demos and games that uses some timings tricks to make special effects, that prevents it from working properly. For example, Green Beret exposes a heavy character flickering and honestly, I don't know how to solve it.

## Acknowledgment

Some Bus and BusComponent structures was inspired by the work in https://efepuntomarcos.wordpress.com/2012/08/27/hazte-un-spectrum-1-parte/#comments (YASS emulator develop process).