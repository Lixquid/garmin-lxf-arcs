# LxF Arcs

A watch face for Garmin devices. Minimalist, circular, customisable.

![Splash image](misc/images/1.png)

## Features

- Customisable colours
- Customisable layouts: 12 or 24 hour, optional minutes arc, optional seconds
  arc, optional date, optional battery indicator
- Customisable between filled arcs and cutout circles
- Customisable arc sizes
- Customisable hour marks: None, dots, sticks, large or small numbers
- Customisable arc segments

## Legend

- Outermost arc: Seconds (can be disabled)
- Middle arc: Minutes (can be disabled)
- Innermost arc: Hours
- Central number: Day of the month (can be disabled)
- Central semi-circle: Battery indicator (can be disabled)

## Settings

- Background Color: The colour of the background
- Foreground Color: The colour of the arcs and text
- Layout: Which arcs to show
- Dynamic Arc Widths: If true, arcs will grow to fill the available space,
  otherwise they will be a fixed size
- Hour Marks Style: The style of hour marks. If "None", the timing arcs will
  increase in size to fill the space.
- Show Date: If a number representing the day of the month should be shown
- Show Battery: If the battery indicator should be shown
- Numeric Hour Marks: Shows numbers at the hour positions
- Cutout Mode: If true, circles with a small notch will be used instead of
  filled arcs
- Segmented Arcs: If true, the arcs will be separated into 12 or 24 segments
  instead of being a continuous arc.

<details>
<summary><h2>Developer Documentation</h2></summary>

## Preparing a release

To perform a release:

- Create an entry in [CHANGELOG.md](CHANGELOG.md) under the next version
- Update README.md with features / screenshots
- Update the version number for `AppVersion` in
  [resources/strings.xml](resources/strings.xml).
- Commit with `Version x.x.x`
- Tag that commit as `vx.x.x`

## Taking screenshots

- Screenshots are taken with the Epix Pro (Gen 2) 51mm device
- Simulate time at `2023-01-30 05:35:46`

</details>
