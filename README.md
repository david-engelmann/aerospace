# AeroSpace setup

One config that works the same on the laptop alone and at the office
(vertical Acer on the left, laptop in the middle, HP on the right).

Key symbols: **⌥** Option (Alt) · **⇧** Shift · **⌃** Control · **⌘** Command

## The idea

- **Every app has one letter.** That letter is its workspace: **S** is Slack, **C** is VS Code, **A** is Dia.
- **A workspace shows one window at a time, full size.** If an app has several windows they sit exactly on top of each other and you flip through them.
- **You never arrange anything.** Windows go to their app's letter by themselves, on the laptop or at the office.

## Keys

There are three layers and nothing else to learn.

| Keys | What it does |
| --- | --- |
| **⇧⌥ + letter** | Go to that app. If it isn't open, it launches. |
| **⌃⇧⌥ + letter** | Take the current window to that letter and go with it. |
| **⌥ + key** | Everything about windows (table below). |

| ⌥ key | What it does |
| --- | --- |
| ⌥\` | Next window in this workspace, which is usually the next window of this app (⇧⌥\` for previous) |
| ⌥Space | Find any window by typing its name (Raycast Switch Windows) |
| ⌥Tab | Back to the window you were just in |
| ⌥[ / ⌥] | Previous / next workspace that has windows |
| ⌥H / J / K / L | Focus left / down / up / right; crosses to the next monitor at the edge |
| ⌥1 / ⌥2 / ⌥3 | Left / middle / right monitor (office only) |
| ⌥E | Show this workspace's windows side by side |
| ⌥, | Back to one at a time |
| ⌥W | Fullscreen the window (use this, never the green button) |
| ⌃⌥H / J / K / L | Move the window within a side-by-side layout |
| ⌥- / ⌥= | Shrink / grow the window in a side-by-side layout |

## Letters

| Letter | Apps | Office screen |
| --- | --- | --- |
| **A** | Dia | HP (right) |
| **B** | Chrome | HP |
| **D** | TablePlus | HP |
| **P** | Postman | HP |
| **Q** | LM Studio | HP |
| **W** | Wave | HP |
| **C** | VS Code | Acer (left, vertical) |
| **G** | Grok Bot | Acer |
| **K** | Docker | Acer |
| **T** | WezTerm, Warp | Acer |
| **S** | Slack | Laptop (middle) |
| **J** | Linear, Calendar | Laptop |
| **N** | Notion | Laptop |
| **M** | Spotify | Laptop |
| **F** | Finder, Preview | Laptop |
| **E** | System Settings, Print Center | Laptop |
| **O** | Codex, Claude, Kimi Code, zcode, MiniMax Code | Laptop |
| **V** | Obsidian | Laptop |

On the laptop alone, every letter lives on the laptop screen. Calculator, Raycast,
Archive Utility and Installer windows float on top of whatever you're in.

## Everyday use

**Go to an app.** ⇧⌥ + its letter. Clicking its Dock icon or its pill in the bar does the same thing.

**Flip between an app's windows.** ⌥\`. With eight VS Code windows, ⌥\` walks through them in order.

**Jump straight to one specific window.** ⌥Space, type a few letters of its title
(`maidan`, `soundcheck`, `ENG-6840`), Return. This is the fast way between agent windows.

**Bounce between two things.** ⌥Tab goes back to the window you were just in,
for example an agent in VS Code and a Slack thread.

**Open another window of an app.** Use the app's own shortcut (⌘N). It lands on the
app's letter, on top of the others.

**See two windows at once.** ⌥E for side by side, ⌥, to go back.

**Put a window somewhere else.** ⌃⇧⌥ + letter. It stays there until the next arrange.

**Dock or undock at the office.** Do nothing. Workspaces move to their screens,
everything re-sorts, and the bar redraws within a couple of seconds.

## The bar

- Each pill is a workspace that has windows: its letter plus one icon per app. Empty workspaces are hidden.
- The bright pill is where you are. At the office, an outlined pill is what's showing on that screen.
- Click a pill to go there.
- An orange **SERVICE** badge means service mode is on (see below).
- A red **AeroSpace can't see windows** badge means macOS's Accessibility layer is broken. See Troubleshooting.

## Two things that break it

1. **The green fullscreen button (or ⌃⌘F).** macOS moves that window to its own hidden
   desktop where AeroSpace can't reach it. The app then looks like it has no window,
   so clicking its Dock icon opens a new one. Use **⌥W** instead.
   If it happens anyway, ⌃⌥/ then A puts it back.
2. **Extra macOS desktops.** Keep exactly one desktop in Mission Control. Windows on
   another desktop are invisible to AeroSpace.

## Service mode

Press **⌃⌥/**, then one key. It returns to normal by itself.

| Key | What it does |
| --- | --- |
| **A** | Arrange: exit native fullscreen, send every window to its letter, one window at a time everywhere |
| R | Reset the current workspace's layout |
| F | Float / unfloat the current window |
| B | Reload the bar |
| Backspace | Close every window in this workspace except the current one |
| Esc | Reload the config |

**⌃⌥/ then A fixes almost anything that looks wrong.**

## Troubleshooting

| Symptom | Fix |
| --- | --- |
| Windows are side by side, on the wrong letter, or an app opens a new window instead of showing its existing one | ⌃⌥/ then A |
| Red "AeroSpace can't see windows" badge | Click it and check AeroSpace is switched on under Accessibility. If it already is, macOS's Accessibility layer is broken for this login session (seen after the window server hung on wake); reboot. |
| Keys do nothing | Run `aerospace list-workspaces --focused`. If it hangs: `pkill -x AeroSpace; open -a AeroSpace` |
| ⌥Space does nothing | Open Raycast, run "Switch Windows" once, and choose **Always Run Command** when asked |
| Bar looks stale | ⌃⌥/ then B |
| Focus jumps to Slack by itself | Known AeroSpace problem ([discussion 1939](https://github.com/nikitabobko/AeroSpace/discussions/1939)); no config fix |

## How it's wired

| File | Job |
| --- | --- |
| `aerospace.toml` | Keys, app → letter rules, letter → monitor rules. Reloads on save. |
| `arrange.sh` | The known-good state. Runs at startup, on dock/undock, and on ⌃⌥/ A. |
| `launch-if-empty.sh` | Launches the app when you go to a letter that has no windows. |
| `~/.config/sketchybar/plugins/workspaces.sh` | Draws the pills. Runs on workspace switch, window open/close, dock/undock and wake. |
| `~/.config/sketchybar/items/spaces.sh` | Creates the pills and the red badge. |
| `~/.config/borders/bordersrc` | Window border colors; kept alive by `~/Library/LaunchAgents/local.borders.plist`. |

Every script that calls the `aerospace` command wraps it in a timeout, so a slow
AeroSpace can never pile up stuck processes.

### Add an app

1. Find its bundle ID: `aerospace list-apps` while it's running.
2. Add it to the `on-window-detected` list in `aerospace.toml`:

   ```toml
   { if = 'test %{app-bundle-id} = com.example.app', run = 'move-node-to-workspace X' },
   ```

3. If it's the main app for that letter, point the letter's `alt-shift-x` line at it
   (`-b <bundle id>`), so ⇧⌥X launches it.

### Requirements

- AeroSpace 0.21 or newer: `brew install --cask nikitabobko/tap/aerospace`
- SketchyBar and JankyBorders: `brew tap FelixKratz/formulae && brew install sketchybar borders`
- `jq` (the bar uses it): `brew install jq`
- Raycast, for ⌥Space
- Fonts: `brew install --cask font-hack-nerd-font`, plus
  [sketchybar-app-font](https://github.com/kvndrsslr/sketchybar-app-font) in `~/Library/Fonts`
- macOS settings: one desktop in Mission Control; "Displays have separate Spaces" off;
  "Automatically rearrange Spaces" off
