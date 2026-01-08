# SpecList - AMX Mod X Plugin

## Overview
Simple spectator list HUD plugin for Counter-Strike 1.6 servers.  
Displays a list of players currently spectating each alive player.

## Features
- Shows "Spectating: [player name]" + list of spectators in HUD
- Toggle on/off with `/speclist`
- Admins with immunity flag are hidden from the list by default when `amx_speclist_immunity` is 1
- Clean gray HUD text
- Efficient task-based update every 1 second

## Commands
- `/speclist` → Toggle spectator list visibility (ON/OFF)

## CVARs (server.cfg / amxx.cfg)
- `amx_speclist "1"` → Enable/disable the plugin (1 = on, 0 = off)  
- `amx_speclist_immunity "1"` → Hide admins with immunity flag from spec list by default (1 = on, 0 = off)

## Credits
- **ftl~** 