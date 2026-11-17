# PvP Portraits

A WoW: Forever successor to [Simple Class Portraits](https://github.com/ArtSabintsev/Simple-Class-Portraits).

While you are in **world PvP** (flagged) or **structured PvP** (battlegrounds / arenas), other players’ unit-frame portraits become their **class icons**. Outside PvP, faces stay as Blizzard draws them.

This does **not** toggle Forever’s built-in Options (`Replace Player Frame Portraits` / `Replace My Frame Portrait`). It only hooks portrait updates while a PvP context is active.

## Install

1. Copy the `PvPPortraits` folder into your Forever AddOns directory, for example:
   - `World of Warcraft/_forever_/Interface/AddOns/PvPPortraits`
2. Restart the client or `/reload`.
3. Enable **PvP Portraits** on the AddOns list at character select if needed.

## Behavior

| Situation | Portraits |
| --- | --- |
| Battleground or arena | Other players → class icons |
| You are PvP-flagged (or FFA) | Other players → class icons |
| Otherwise | Default face portraits |

Your own portrait and your pet are never changed.

## Requirements

- World of Warcraft: Forever (`## Interface: 16001`)

## License

MIT — see [LICENSE](LICENSE).
