# 3LED

iOS/macOS client for LIFX lightbulbs

## Todo

### Tasks

- Initial menu configuration
    - Will need multiple request resolution
    - Look into NSMenuDelegate and that special run loop thing
    - Request resolution will need timeouts
    - Should show blanked out 'Light is offline' menu instead of 'Set color...' etc

- Set up window reuse
    - Color and gradient should be mutually exclusive
   
- Open on startup option

- Don't forget to prompt on startup to add a light, if there are no lights; and show an empty menu if there are no lights

### Add Light

- Finish modal promise helper
- If light is already added, move it to the end
- Set up text field validation (i.e. valid IP address)
    - Should add `try` helper to IPv4Address
    - Should also do this in promises where possible

### Remove Light

- Finish menu state stuff first
    - LIFXConnection should have an 'address' helper...

### Set Light Color

- Is this finished?

### Set Light Waveform

- Finish this view controller and explore how waveform setting should work

### Set Light Name

- Reuse standard alert with text field

### Bugs

- getHue:saturation:brightness:alpha: not valid for the NSColor NSCalibratedWhiteColorSpace
