# 3LED

iOS/macOS client for LIFX lightbulbs

## Todo

- Set up window reuse
   - Color, gradient, name etc should be mutually exclusive
- Standardised IPv4Address validation
- Persist saved lights

### Menu

- Menu should be refreshed from scratch when opening the utility; can we use the menu validation functions? Can this be done asynchronously?
   - Map promises and use a resolved state to enable/disable menu items 
   - Only thing saved should be a list of addresses, in User defaults
- Don't forget to prompt on startup to add a light, if there are no lights; and show an empty menu if there are no lights
- Add submenu for each light
   - Power
   - Set Color...
   - Set Gradient...
   - Set Name...

### LightViewController

- Should be a modal hud
- Rename light
- Hide window until loaded...? Or hide color well

### Bugs

- getHue:saturation:brightness:alpha: not valid for the NSColor NSCalibratedWhiteColorSpace
