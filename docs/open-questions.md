# Open questions and evidence plan

Unknowns here are intentionally unresolved. Do not fill them from intuition or by copying the reference implementation without corroboration.

## Highest-risk protocol questions

1. What exact original PS2 client revisions are in scope, and what are their endpoint discovery, DNS, patch/MOTD, authentication and game-server selection sequences?
2. What are canonical framing fields, per-field byte order, length encoding, CRC parameters and validation behavior? Are there protocol variants by client/disc version?
3. What is the full session lifecycle, including connection/session identifiers, retry, duplicate/reorder, ack masks, fragmentation, timeouts and reconnect/rebind behavior?
4. What password/authentication cryptography is required for target clients? Which bytes are encrypted, with what key derivation/padding, and is account service separate from in-game auth in the target flow?
5. What message sequence and state is required for character list, character selection, memory dump, world entry, zone transfer and disconnect?
6. What are field-level layouts for client movement, entity replication, stat/group/buff channels, inventory, merchant, loot, spells, combat and quest messages?
7. How does the client react to unsupported opcodes, malformed lengths, unknown flags, stale sessions and server overload?

## Highest-risk data/game questions

- Which gameplay state is persistent versus runtime-only, and at what transaction boundary must it be saved to avoid duplication/loss?
- Are character IDs, item IDs, zone IDs and entity IDs protocol-visible and constrained by client behavior?
- What authoritative rules are needed for equipment, stack splitting, merchant prices, loot ownership, death/respawn, abilities and quest state?
- Which spawn/zone geometry facts can be derived from public technical evidence without copying proprietary assets? What content is independently authored?
- What account uniqueness and concurrent-login rules does the original client expect? Can one player session attach to a fresh transport connection?

## Evidence plan

1. Preserve and annotate lawful packet captures from a known original PS2 client path; include both directions and connection metadata, and redact account credentials.
2. Build a reproducible replay harness to compare candidate encoders against captured server datagrams; record client revision and capture provenance.
3. Review public technical documentation and independent emulator/interoperability research; cite exact source, date and confidence.
4. Inspect the precise reference parser/serializer paths for each milestone feature, but mark server-specific choices separately from observed client behavior.
5. Validate field hypotheses with controlled client experiments. Change one behavior at a time and preserve successful/failing fixtures.
6. Promote a source-derived implementation fact to CONFIRMED — reference only when direct repository evidence supports it. Promote a client/protocol claim to CONFIRMED — client/protocol only when the capture/experiment criteria in [protocol-evidence-plan.md](protocol-evidence-plan.md) are met; retain UNKNOWN when evidence conflicts.

## Operational questions

- What deployment environment and DNS/HTTP bootstrap are required for a physical PS2 client on the intended network?
- What initial capacity target is desired? Keep it configurable; measure packet sizes, CPU, DB load and queue behavior before setting production values.
- What logging retention, privacy, audit, backup and recovery requirements apply?
- Which emulator experiments (PCSX2, later PS2 Classic/RPCS3) help isolate client behavior, while remaining optional server-side?

