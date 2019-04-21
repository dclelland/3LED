# 3LED

A simple macOS menu bar app for managing a collection of LIFX light bulbs.

3LED is a bare bones, open source utility; currently it just has facility for toggling lights on and off, as well as adjusting their colors.

## Screenshot

![3LED screenshot](/Screenshot.png?raw=true "3LED screenshot")

## Building

Just open `3LED.xcworkspace` in Xcode and hit build (as of the time of writing the latest version is Xcode 10.2).

### Dependencies

- [LIFXClient](https://github.com/dclelland/LIFXClient)
- [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin)

## Privacy policy

3LED does not gather any kind of user data.

## Wishlist

- Investigate menu run loop issues
- Keyboard shortcuts (check out [HotKey](https://github.com/soffes/HotKey), [Magnet](https://github.com/Clipy/Magnet), or [SpiceKey](https://github.com/Kyome22/SpiceKey))
- Waveform editing
- Scene manager

---

Just a quick note: 3LED itself is a paid app, but I provide the source code free of charge as a learning resource. I ask that you kindly don't put clones of 3LED in the App Store.
