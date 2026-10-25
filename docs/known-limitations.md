# Known limitations and research gaps

## Reference limitations observed

- The upstream README marks the repository deprecated and legacy-only. Treat it as historical public reference, not the current canonical server.
- Authentication documentation says quick login accepts arbitrary information; code shows account-existence checks in the game handler when optional AES decryption is disabled, while the TCP account server contains configurable decryption and account SQL paths. The exact shipped/deployed security posture is not established.
- The main UDP receive buffer is 300 bytes; outbound maximum is `0x530`. Whether all message sizes/fragment cases are handled is unknown.
- The game receive listener catches several socket exceptions, logs generic text, and loops. CRC failure logs but does not immediately return false. `SocketManager` deliberately throws to force bind-any fallback.
- Reliable messages with unexpected sequence values are ignored; source comments defer out-of-order buffering/recovery. Queue comments question retry limits. Robust retransmission guarantees are therefore not established.
- TCP auth receive handling uses a fixed 500-byte receive buffer and interprets a receive as a complete request; TCP is a byte stream, so framing across partial/coalesced receives is an important unresolved correctness risk.
- Static manager/session collections and mutable runtime state have limited explicit ownership; thread-safety and shutdown behavior are uncertain.
- Account tracker uses a plain mutable `List`; concurrent connection handlers could mutate/read it without synchronization.
- Some server settings and endpoints are hard-coded or partially configured; app.config and Docker compose have development IPs/credentials and external DB exposure.
- Game opcode dispatch catches all exceptions and turns them into an “unknown opcode” path, obscuring handler failures.
- Source includes explicit incomplete behavior: TODOs for pathfinding and movement distribution, group/ignore behavior, combat/CM work, inventory stacking/lore/rearrangement, corpse ownership, and save-on-character-change; at least one `NotImplementedException` in item-to-player inventory path; some handlers are default/canned responses.
- README reports rudimentary player replication, global shout, world populated with NPCs, and character save on logoff/disconnect. These are repository statements, not independently verified quality/coverage.
- CI starts containers but no build/test/assertion steps are shown in the workflow. The auth test solution exists, but no test source was found in the survey.
- Schemas contain large sample datasets that may be proprietary or user contributed. They are not a suitable content source for Nighthaven.

## Protocol unknowns

See [open-questions.md](open-questions.md). Highest risk: exact original PS2 handshake sequence; capture-verified framing, CRC and byte order; authentication/password encryption; character/world entry state machine; reliable message behavior; movement replication; client revision differences; endpoint discovery and DNS/patch bootstrap.

## Scope limitation of this report

This was a source/config/schema survey. No server was launched, no database was provisioned, no client traffic was captured, no external source was consulted, and no tests/builds were run. The reference repository was read only. This report cannot certify protocol conformance or operational security.

