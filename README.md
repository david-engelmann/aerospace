# AeroSpace + SketchyBar Tiling Window Manager Setup

A mnemonic-based workspace system with automatic app placement, multi-monitor support, and a live status bar showing workspace icons.

## Quick Reference

```
Alt+Shift+[Letter]       → Switch to workspace      (e.g. Alt+Shift+C = Code)
Cmd+Alt+[Letter]         → Launch app               (e.g. Cmd+Alt+B = Chrome)
Cmd+Alt+Shift+[Letter]   → Move window to workspace (e.g. Cmd+Alt+Shift+T = Terminal)
Ctrl+Alt+Shift+[Letter]  → Move window and follow   (e.g. Ctrl+Alt+Shift+G = Grok Bot)
Alt+H/J/K/L              → Focus left/down/up/right (vim-style)
Alt+1/2/3                → Jump to Code / Slack / Dia screens
Alt+Tab                  → Toggle last workspace
Ctrl+Alt+/               → Enter service mode
```

---

## Monitor Layout

Apps auto-assign to their workspace and monitor when opened.

```
┌──────────────────────┐  ┌──────────────────────┐  ┌──────────────────────┐
│  HP Pavilion32       │  │  XF273 S (Vertical)  │  │  Built-in Retina     │
│  Main + Tools        │  │  Development         │  │  Comms & Planning    │
│                      │  │                      │  │                      │
│  A  Dia (AI)         │  │  C  VS Code          │  │  S  Slack            │
│  B  Browser          │  │  T  WezTerm, Warp    │  │  J  Linear, Calendar │
│  D  Database         │  │  K  Docker           │  │  N  Notion           │
│  P  Postman          │  │  G  Grok Bot         │  │  M  Spotify (Music)  │
│  W  Wave             │  │                      │  │  F  Finder, Preview  │
│  Q  LM Studio        │  │                      │  │  E  Settings         │
│                      │  │                      │  │  O  Codex, Claude,   │
│                      │  │                      │  │     Kimi, zcode      │
│                      │  │                      │  │  V  Obsidian         │
└──────────────────────┘  └──────────────────────┘  └──────────────────────┘
```

> **Note**: Workspace routing uses monitor name patterns first (`HP Pavilion32`,
> `XF273 S`, `built-in`) because macOS can renumber displays after hardware changes.
> The numeric entries in `[workspace-to-monitor-force-assignment]` are fallbacks.

---

## Keybindings

### Monitor Anchors & Navigation

| Keybinding | Action |
|---|---|
| `Alt+1` | Jump to Code on XF273 S |
| `Alt+2` | Jump to Slack on built-in display |
| `Alt+3` | Jump to Dia on HP Pavilion32 |
| `Alt+Shift+Left/Right` | Focus monitor left/right (wraps) |
| `Cmd+Alt+Tab` | Cycle to next monitor |
| `Cmd+Shift+Alt+Tab` | Cycle to previous monitor |

Mouse cursor follows focus automatically.

### Window Focus (Vim-style)

| Keybinding | Action |
|---|---|
| `Alt+H` | Focus left |
| `Alt+J` | Focus down |
| `Alt+K` | Focus up |
| `Alt+L` | Focus right |

### Window Cycling

| Keybinding | Action |
|---|---|
| `Alt+\`` | Focus next window in workspace |
| `Alt+Shift+\`` | Focus previous window in workspace |

### Workspace Switching

| Keybinding | Workspace | App | Monitor |
|---|---|---|---|
| `Alt+Shift+B` | **B**rowser | Chrome | HP Pavilion32 |
| `Alt+Shift+C` | **C**ode | VS Code | XF273 S |
| `Alt+Shift+T` | **T**erminal | WezTerm | XF273 S |
| `Alt+Shift+D` | **D**atabase | TablePlus | HP Pavilion32 |
| `Alt+Shift+G` | **G**rok Bot | Grok Bot | XF273 S |
| `Alt+Shift+P` | **P**ostman | Postman | HP Pavilion32 |
| `Alt+Shift+J` | **J**ira | Linear | Built-in |
| `Alt+Shift+S` | **S**lack | Slack | Built-in |
| `Alt+Shift+N` | **N**otion | Notion | Built-in |
| `Alt+Shift+K` | **K**ubernetes | Docker | XF273 S |
| `Alt+Shift+F` | **F**inder | Finder | Built-in |
| `Alt+Shift+M` | **M**usic | Spotify | Built-in |
| `Alt+Shift+A` | **A**I | Dia | HP Pavilion32 |
| `Alt+Shift+E` | pr**E**ferences | System Settings | Built-in |
| `Alt+Shift+O` | c**O**dex | Codex | Built-in |
| `Alt+Shift+W` | **W**ave | Wave | HP Pavilion32 |
| `Alt+Shift+Q` | LM (**Q**) | LM Studio | HP Pavilion32 |
| `Alt+Shift+V` | Obsidian **V**ault | Obsidian | Built-in |

### App Launchers

| Keybinding | Application |
|---|---|
| `Cmd+Alt+B` | Google Chrome |
| `Cmd+Alt+C` | VS Code |
| `Cmd+Alt+I` | WezTerm |
| `Cmd+Alt+D` | Dia |
| `Cmd+Alt+G` | Grok Bot |
| `Cmd+Alt+K` | Docker |
| `Cmd+Alt+N` | Notion |
| `Cmd+Alt+P` | Postman |
| `Cmd+Alt+L` | Linear |
| `Cmd+Alt+O` | Codex |
| `Cmd+Alt+W` | Wave |
| `Cmd+Alt+Q` | LM Studio |
| `Cmd+Alt+V` | Obsidian |
| `Cmd+Alt+R` | Reload SketchyBar |

### Move Window to Workspace

Send current window to any workspace: `Cmd+Alt+Shift+[Letter]`

Same letter pattern as switching: `Cmd+Alt+Shift+C` sends to Code, `Cmd+Alt+Shift+B` sends to Browser, etc.

Move current window and follow it immediately: `Ctrl+Alt+Shift+[Letter]`

This uses the same workspace letters, so `Ctrl+Alt+Shift+G` sends the current window to Grok Bot and switches there.

### Layout Controls

| Keybinding | Action |
|---|---|
| `Alt+E` | Toggle horizontal/vertical tile |
| `Alt+,` | Toggle accordion layout |
| `Alt+W` | Toggle fullscreen |
| `Alt+Y` | Join right neighbor below (split layout) |
| `Alt+-` | Shrink window |
| `Alt+=` | Grow window |

### Window Movement

Move windows with `Ctrl+Alt+H/J/K/L` (same directions as focus).

### Workspace Utilities

| Keybinding | Action |
|---|---|
| `Alt+Tab` | Toggle between last two workspaces |
| `Alt+[` / `Alt+]` | Previous / next occupied workspace on this monitor (wraps) |
| `Alt+Shift+Tab` | Move current workspace to next monitor |

---

## Service Mode

Press `Ctrl+Alt+/` to enter service mode, then:

| Key | Action |
|---|---|
| `Esc` | Reload config & exit |
| `R` | Reset/flatten workspace layout |
| `F` | Toggle floating/tiling |
| `Backspace` | Close all windows except current |
| `Ctrl+Alt+H/J/K/L` | Join window with neighbor |

All commands auto-return to main mode.

---

## Common Workflows

### Development Cycle

```
Alt+Shift+C       → Switch to Code workspace (VS Code)
Alt+Shift+T       → Switch to Terminal (WezTerm)
Alt+Shift+G       → Switch to Grok Bot
Alt+Tab           → Toggle between recent workspaces
Alt+Shift+B       → Check something in the browser
Alt+1             → Jump back to development monitor
```

### Debugging Flow

```
Alt+Shift+C       → Code workspace
Alt+Shift+K       → Docker workspace (check containers)
Alt+Shift+D       → Database workspace (TablePlus)
Alt+Shift+P       → Postman (test API)
```

### Communication Check

```
Alt+2             → Jump to built-in display
Alt+Shift+S       → Slack
Alt+Shift+J       → Linear (check tickets)
Alt+Shift+N       → Notion (docs)
```

### Moving a Window

```
Alt+H/J/K/L             → Focus the window you want to move
Cmd+Alt+Shift+[Letter]  → Send it to target workspace
Alt+Shift+[Letter]      → Follow it there (optional)
Ctrl+Alt+Shift+[Letter] → Send and follow in one step
```

### Fixing a Messy Layout

```
Ctrl+Alt+/        → Enter service mode
R                 → Flatten/reset the workspace tree
```

---

## Companion Tools

This setup uses the following tools together:

### Currently Installed

| Tool | Purpose | Config |
|---|---|---|
| [AeroSpace](https://github.com/nikitabobko/AeroSpace) | Tiling window manager | `~/.config/aerospace/` |
| [SketchyBar](https://github.com/FelixKratz/SketchyBar) | Custom macOS menu bar | `~/.config/sketchybar/` |
| [JankyBorders](https://github.com/FelixKratz/JankyBorders) | Window border highlights | `~/.config/borders/bordersrc`, kept alive by `~/Library/LaunchAgents/local.borders.plist` |
| [Neovim](https://neovim.io/) | Terminal editor | `~/.config/nvim/` |
| [WezTerm](https://wezfurlong.org/wezterm/) | GPU-accelerated terminal | — |

### Recommended Additions

| Tool | What It Does | Install |
|---|---|---|
| [Raycast](https://www.raycast.com/) | Spotlight replacement with extensions, clipboard manager, snippets | `brew install --cask raycast` |
| [alt-tab-macos](https://github.com/lwouis/alt-tab-macos) | Windows-style alt-tab with window previews | `brew install --cask alt-tab` |
| [Karabiner-Elements](https://karabiner-elements.pqrs.org/) | Remap keys (e.g. Caps Lock → Hyper key for more shortcuts) | `brew install --cask karabiner-elements` |
| [skhd](https://github.com/koekeishiya/skhd) | Extra global hotkeys beyond aerospace bindings | `brew install koekeishiya/formulae/skhd` |
| [Homerow](https://www.homerow.app/) | Keyboard-driven click targets (like Vimium for all macOS) | `brew install --cask homerow` |

**Tip**: Karabiner + Hyper key (Caps Lock → Cmd+Alt+Ctrl+Shift) gives you a whole extra modifier layer for shortcuts without conflicts.

---

## Installation

### Prerequisites

```bash
brew tap FelixKratz/formulae
brew install --cask aerospace
brew install borders sketchybar
```

### Font Required for SketchyBar

```bash
# sketchybar-app-font for workspace app icons
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf -o ~/Library/Fonts/sketchybar-app-font.ttf

# Hack Nerd Font for icons
brew install --cask font-hack-nerd-font
```

### Config Files

```
~/.config/aerospace/aerospace.toml    — Main AeroSpace config
~/.config/sketchybar/sketchybarrc     — SketchyBar config
~/.config/sketchybar/plugins/         — SketchyBar plugin scripts
~/.config/nvim/                       — Neovim config
```

### Reload After Changes

- **AeroSpace**: automatic on save (`auto-reload-config`); manual: `Ctrl+Alt+/` then `Esc`
- **SketchyBar**: `Cmd+Alt+R` or `sketchybar --reload`
- **Borders**: `launchctl kickstart -k gui/$(id -u)/local.borders`

Requires AeroSpace 0.21+ (`config-version = 2`, new `on-window-detected` syntax).

---

## Troubleshooting

### Apps Landing on Wrong Monitor

Monitor name patterns are more stable than macOS display numbers. If apps go to the wrong screen:

1. Open System Settings > Displays > Arrangement
2. Confirm `HP Pavilion32` is the Dia/main display
3. Check `aerospace list-monitors` for the exact Acer and HP Pavilion names (`XF273 S`, `HP Pavilion32`)
4. Update `[workspace-to-monitor-force-assignment]` in `aerospace.toml`
5. Update the `workspace_display()` function in `sketchybarrc` to match
6. Reload both configs

### SketchyBar Icons Not Updating

```bash
# Force reload
sketchybar --reload

# Check if the update script is executable
chmod +x ~/.config/sketchybar/plugins/*.sh
```

### Everything Stops Responding (keys, pickers, bar)

The AeroSpace server has stalled. Check:

```bash
perl -e 'alarm 3; exec @ARGV' aerospace list-workspaces --focused || echo "server stalled"
pgrep -f '^aerospace ' | wc -l   # stuck CLI clients piling up
```

If it's stalled, quit and reopen AeroSpace (`osascript -e 'quit app "AeroSpace"'`, then
`open -a AeroSpace`; if the quit hangs, `pkill -x AeroSpace` first). Every script that calls the
`aerospace` CLI should wrap it in a timeout like the one above, so a stall can't pile up processes.

### Layout Feels Broken/Jumpy

```
Ctrl+Alt+/  →  R       (flatten workspace tree)
Ctrl+Alt+/  →  Esc     (reload config)
```

### Finding an App's Bundle ID

To add a new app to auto-assign:

```bash
osascript -e 'id of app "AppName"'
```

Then add an entry to the `on-window-detected` list in `aerospace.toml`:

```toml
{ if = 'test %{app-bundle-id} = com.example.app', run = 'move-node-to-workspace X' },
```
