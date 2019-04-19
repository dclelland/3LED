# 3LED

iOS/macOS client for LIFX lightbulbs

## Todo

### Tasks

- Initial menu configuration
    - Look into NSMenuDelegate and that special run loop thing
        - Will need to add timeouts to connection request
    
- Set up correct initial window positions

- Don't forget to prompt on startup to add a light, if there are no lights

### Add Light/Remove Light

- Finish alert promise helpers
   - Regular alert
   - Alert with text field

### Set Light Color

- Is this finished?

### Set Light Waveform

- Finish this view controller and explore how waveform setting should work

### Set Light Name

- Reuse standard alert with text field

### Bugs

- getHue:saturation:brightness:alpha: not valid for the NSColor NSCalibratedWhiteColorSpace
