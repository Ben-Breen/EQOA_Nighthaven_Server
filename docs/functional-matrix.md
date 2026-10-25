# Reference functionality matrix

Status describes evidence in the surveyed public reference implementation, not official EQOA completeness. “Implemented” means a functioning code path is visible; it does not certify gameplay accuracy or robustness.

| Feature | Status | Evidence and limitation |
|---|---|---|
| Authentication | PARTIAL | TCP account server and in-game auth handler exist; README documents quick login; optional crypto disabled in checked-in game config, and game handler then checks account existence rather than password |
| Account handling | PARTIAL | SQL account create/existence/verify paths, create/login/change-password handlers; other account services disabled; change-password source sends success without old-password verification |
| Character creation | IMPLEMENTED | Client parser, default character templates, SQL stored procedure creation and list response; validations/placeholders remain |
| Character selection | IMPLEMENTED | Character list generation and selected-character dispatch; precise flow/recovery needs capture validation |
| World entry | PARTIAL | Session ack and enable-channel logic, memory dump and in-world entity setup; end-to-end reliability/state sequence not independently verified |
| Zones/world state | PARTIAL | World/map managers, zone data, scripts and NPC records; no proof of complete zone coverage or transfer correctness |
| Movement | PARTIAL | Client state/unreliable parsing and object updates; source comments call distribution rudimentary/choppy and movement values unresolved |
| NPCs | PARTIAL | NPC/entity managers, database NPC rows and many Lua scripts; pathfinding TODO and behavior/content completeness unknown |
| Spawning | PARTIAL | NPC data and world initialization present; lifecycle/timing/respawn completeness not established |
| Combat | PARTIAL | Attack handler and entity damage/death code exist; observed attack handler applies fixed 500 damage; broader combat called TODO in README |
| Abilities/spells | PARTIAL | Spell pattern/player spell/hotbar models and serialization exist; README lists spell/opcode work to do; full cast/effect behavior not shown |
| Inventory | PARTIAL | SQL-backed character inventory, item containers and handlers; explicit TODOs for stacks, lore, rearrangement and at least one `NotImplementedException` path |
| Items/equipment | PARTIAL | Equip/unequip/repair, item patterns, equipment models exist; interaction paths include TODOs and default data concerns |
| Loot | PARTIAL | Loot messages, corpse and item handlers exist; corpse owner/group TODO and end-to-end correctness unknown |
| Merchants | PARTIAL | Merchant menu/buy/sell and NPC item data exist; range/type validation comments indicate permissive/unfinished checks |
| Quests | PARTIAL | Quest/playerquest schema and server/client quest messages/Lua scripts exist; storage duplication and supported quest coverage unknown |
| Groups | PARTIAL | Group managers and several invite/member/chat opcodes; README lists group mechanisms as TODO; ignore/edge behavior incomplete |
| Guilds | STUBBED | Guild opcode names/constants exist but no complete guild service/handler evident in inspected dispatch |
| Chat | PARTIAL | Say and global shout handlers, group chat; tells/replies called out as TODO; shout explicitly global for now |
| Persistence | PARTIAL | MySQL schema/procedures, load/save methods and README claim save on disconnect; source TODOs and mixed immediate/deferred writes leave durability unclear |
| Death/respawn | PARTIAL | Damage/death code and character died message; respawn behavior not established |
| Disconnect/reconnect | PARTIAL | Reset/disconnect removes sessions and some save behavior claimed; grace/rebind restoration not evident |
| Administrative commands | EXPERIMENTAL | README describes in-game admin chat to adjust character state; character flags/admin logic exist, authorization model not audited |
| Logging | PARTIAL | Custom logger and console messages across components; structured correlation, rotation, redaction and metrics not evident |
| Monitoring | MISSING | No health/readiness/metrics/tracing implementation identified in survey; CI starts containers but has no visible assertion checks |
| Configuration | PARTIAL | app.config and server list settings exist; endpoint fallback is hard-coded/forced; legacy sample uses LAN addresses and placeholder secrets |

