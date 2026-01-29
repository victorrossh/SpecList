# SpecList - AMX Mod X Plugin

## Credits
- **ftl~** 
- **Mrshark45**

## Overview
Simple spectator list HUD plugin for Counter-Strike 1.6 servers.  
Displays "Spectating: [player name]" followed by the list of players currently spectating each alive player — shown only to the alive player and their spectators.

## Features
- Clean HUD display showing who is spectating each alive player
- Gray text positioned at the top-right area
- Players can toggle visibility with `/speclist`
- Admins can hide themselves from the spec list using `/hide`
- Updates every ~1 second using an efficient repeating task
- Natives support for other plugins:
  - `toggle_speclist(id)` — Toggle display for a player
  - `get_bool_speclist(id)` — Check if display is enabled for a player
- No bots are shown in the list
- Only shows real spectators (not alive players or disconnected users)

## Commands
- `say /speclist` or `say_team /speclist` → Toggle your spectator list visibility (ON/OFF)
- `say /hide` → **Admin only** — Toggle whether you appear in other players' spec lists

## CVARs
- `amx_speclist "1"` → Enable/disable the plugin (1 = on, 0 = off)  