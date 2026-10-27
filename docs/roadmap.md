# Nighthaven architecture and research roadmap

This roadmap is ordered to reduce uncertainty before committing to broad game implementation. Each milestone is independently reviewable; experiments should stay disposable until evidence promotes them into the stable core.

## Current checkpoint

[Pass #5 — Client/Protocol Evidence Acquisition](pass5-status.md) has begun. The static artifact inventory is registered; E00 is partial and E01–E11 are not run. Architecture Gate #2 remains PASS, Evidence Acquisition Gate OPEN, and Protocol Implementation Gate CLOSED. MOTD markup remains deferred.

## 0. Evidence baseline

- Preserve the read-only reference boundary and this evidence-tagged survey.
- Inventory available public documents and lawfully collected captures; record client revision, emulator/console path, timestamp, and provenance for each capture.
- Create a protocol hypothesis ledger distinguishing CONFIRMED — reference from CONFIRMED — client/protocol, plus INFERRED and UNKNOWN entries with source/capture links.
- Do not import game art, audio, maps, dialogue, or other proprietary content.

## 1. Minimal protocol laboratory

- Build independent packet fixtures from verified observations; test framing, lengths, byte order per field, CRC, reliable/unreliable channels, sequence wrap, acknowledgements and malformed-input handling.
- Create capture replay/diff tooling and structured unknown-message logging with redaction.
- Validate original PS2 client connection, version/authentication path, session establishment, character list, character select and world entry.
- Keep emulator variants as test environments, not required dependencies.

## 2. Stable server skeleton

- Single modern .NET process with explicit Transport, Protocol, Application, Domain, Persistence, Configuration, and Observability boundaries.
- Typed config, secret injection, minimal bind/exposed ports, startup validation, cancellation-based shutdown, health/readiness and metrics.
- Selected relational database adapter and migrations; backup/restore smoke procedure; repository contract tests when appropriate. Select one backend before persistence implementation; do not build dual adapters for theoretical portability.

## 3. Session reliability and operations

- Implement configurable global capacity, per-IP limits, one active client per account default, and metrics.
- FIFO admission queue with cancellation/timeouts and observable queue position/age.
- Separate session and connection IDs; implement 600-second configurable reconnect grace only after protocol research establishes rebind behavior; test expiry slot release and FIFO admission.
- Exercise packet loss, duplicate/reordered packets, disconnect/reconnect, process restart, DB outage, and graceful shutdown recovery.

## 4. First playable vertical slice

- Operator-prioritized first playable path (2026-10-25): account login, client-driven character creation from an empty character list, refreshed list and selection, then world-server entry. Capture and validate the exchanges for each transition before implementing that path. A pre-provisioned character does not satisfy the standard creation baseline. Continue with a single zone, entity visibility/movement, save/load and disconnect; client reconnect remains conditional on supporting evidence.
- Keep combat, items, NPC scripts and content out until each vertical behavior has capture-backed messages and explicit domain rules.

## Deferred ruleset compatibility research

After the standard creation and world-entry path is proven, a separate future experiment may test candidate nonstandard race/class combinations such as Gnome Monk, Troll Bard or Ogre Bard. A pre-provisioned character may test whether the client can load/display/select a combination, but cannot establish that its creation flow permits or transmits it; that question requires a separate client-driven creation experiment. Such experiments do not count as standard character-creation coverage. Possible Classic, Regular and Chaos variants are future research/planning tracks only here. This roadmap does not define their rules, promise support, or add ruleset architecture to the current slice.

## 5. Incremental gameplay domains

- Add NPC spawn/interaction and deterministic script boundary.
- Add inventory/equipment/merchant transactions; then loot and death/respawn.
- Add combat/abilities with server-authoritative domain tests; then chat, groups, quests and administrative tooling.
- Maintain per-feature protocol coverage and migration/data provenance.

## Acceptance gates

1. Every supported message has a field-level source/capture reference and parser/serializer coverage.
2. Unknown or malformed packets are bounded, observable and do not terminate the process.
3. Session state survives transient disconnect in the documented grace window where the verified protocol permits it; slots and queue recover predictably.
4. Persistence operations are transactional and backup/restore is demonstrated.
5. Clean-room content and code provenance review is complete before distribution.


## Deferred content research leads

The operator identified EQOAEmu and Hagley as possible future research assets. EQOAEmu's rumored open-source direction is unverified; available source/content, completeness, provenance and publication terms for both leads must be checked when their work becomes relevant. No research, import, copying or dependency selection is authorized by listing them here. Broader quests, tradeskills, guilds and content work remain downstream of the first playable login/create-character/world-entry path.
