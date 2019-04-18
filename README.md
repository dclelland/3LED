# 3LED

iOS/macOS client for LIFX lightbulbs

## Todo

### Tasks

- Initial menu configuration
    - Look into NSMenuDelegate and that special run loop thing
        - Will need to add timeouts to connection request
    - Content tweaks:
        - Should show blanked out 'No lights added' if there are no lights added
    
- Set up window reuse
    - Color and gradient should be mutually exclusive

- Don't forget to prompt on startup to add a light, if there are no lights

### Add Light

- Finish modal promise helper
- If light is already added, move it to the end

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
