# Nighthaven architecture and research roadmap

This roadmap is ordered to reduce uncertainty before committing to broad game implementation. Each milestone is independently reviewable; experiments should stay disposable until evidence promotes them into the stable core.

## 0. Evidence baseline

- Preserve the read-only reference boundary and this evidence-tagged survey.
- Inventory available public documents and lawfully collected captures; record client revision, emulator/console path, timestamp, and provenance for each capture.
- Create a protocol hypothesis ledger with CONFIRMED / INFERRED / UNKNOWN entries and source/capture links.
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

- Authentication through the verified client exchange; character list/select; create a character only if needed for the test setup; single zone entry; entity visibility and movement; save/load; disconnect. Test client reconnect only if evidence confirms the target client supports the required rebind behavior.
- Keep combat, items, NPC scripts and content out until each vertical behavior has capture-backed messages and explicit domain rules.

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

