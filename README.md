# 3LED

A simple macOS menu bar app for managing a collection of LIFX light bulbs.

3LED is a bare bones, open source utility; currently it just has facility for toggling lights on and off, as well as adjusting their colors.

### Links

- [3LED on the App Store](https://itunes.apple.com/us/app/3led-menu-bar-client-for-lifx/id1460522983)

### Screenshot

![3LED screenshot](/Screenshot.png?raw=true "3LED screenshot")

## Building

Just open `3LED.xcworkspace` in Xcode and hit build (as of the time of writing the latest version is Xcode 10.2).

### Dependencies

- [LIFXClient](https://github.com/dclelland/LIFXClient)
- [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin)

## Privacy policy

3LED does not gather any kind of user data.

## Wishlist

- Rewrite using the Combine framework once that is available
- Investigate menu run loop issues
- Keyboard shortcuts (check out [HotKey](https://github.com/soffes/HotKey), [Magnet](https://github.com/Clipy/Magnet), or [SpiceKey](https://github.com/Kyome22/SpiceKey))
- Waveform editing
- Scene manager

---

Just a quick note: While 3LED is on the App Store, I provide the source code free of charge as a learning resource. I ask that you kindly don't put clones of 3LED in the App Store.
