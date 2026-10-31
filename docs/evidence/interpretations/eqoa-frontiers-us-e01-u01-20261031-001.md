# E01-U01 — empty update response

Reviewed 2026-10-31. **COMPLETE for one bounded negative observation; E01 remains PARTIAL.** [Sanitized manifest](../manifests/eqoa-frontiers-us-e01-u01-20261031-001.json) registers session `E01-U01-20261031T185944972Z`. Raw bytes remain authoritative in restricted EFS storage outside Git.

## Question and intervention

Would a properly framed HTTP/1.1 200 OK response with Content-Length 0 and Connection close let this client pass updating? This was an UNKNOWN, not an assumed protocol requirement. The operator approved one run including temporary physical disconnection. The previous PNACH and prepared network-profile source were unchanged; the emulator used a separate disposable working card. The v3 lab listener responded only to the exact previously captured 104-byte request, once, on guest-only TAP TCP/7000. No greeting/news, alternate response, account service or automatic retry experiment was included. Harness code and timing also differ from the receive-only run; this is not an exhaustive single-variable causal proof.

## Observations and interpretation

- **CONFIRMED — client/protocol**, scoped to Frontiers US SLUS-20744 / EEEE1FCC in PCSX2 2.8.2.0 with the registered patch/card: the same request was captured, one 57-byte response was transmitted, and the guest acknowledged the complete response plus FIN at TCP level. The ten TCP frames contain one client data frame and one server data frame; both payloads match the listener artifacts byte-for-byte. No subsequent TCP connection appears in the two captured files.
- **CONFIRMED — client/protocol**, same scope: the one F8 screenshot shows the update error. The operator also reported the same error before closing normally. Account login was not reached.
- **INFERRED:** this exact response is insufficient to pass updating in this environment. TCP acknowledgment is not evidence of successful application parsing. The result does not establish whether the cause is HTTP dialect, headers, empty content, encoding, manifest schema or another acceptance condition.
- **UNKNOWN:** an accepted response contract and minimum no-update representation. The `.xml.gz` request suffix alone does not establish actual compression/XML requirements. This run does not reject every possible empty-body response variant or establish behavior on other revisions/physical hardware.

## Integrity, containment and rollback

The package passed 110 synthetic harness checks and three loopback response tests; elevated preflight passed before live launch. TAP capture preceded listener and emulator launch. The one run ended on normal operator close, within its five-minute limit. All 88 recorded file references verify (59 session, 22 embedded run, seven input); all 60 session files and three authorization/observer files report EFS encryption and operator/SYSTEM-only access. The receipt records chat-supplied approval truthfully rather than claiming newly typed terminal consent. Full-flow coverage is not asserted; emulator-intercepted traffic can remain absent from TAP.

The runner records preservation of source ISO/card/original patches. A separate elevated read-only check at 19:03:35Z verifies exact profile rollback, networking/cheats disabled, idle capture, no listener process/port/temporary rule, DNS restored stopped and physical administrative adapter states restored. No additional guest boot occurred. No raw captures, screenshots, cards, BIOS, patch code, assets, private paths, MACs, account values or session secrets are published.

## Next evidence task

Inspect the original client's updater response parser offline and document the smallest supported response contract with source provenance and explicit unknowns before proposing another live variant. Acceptance: identify the relevant success/failure branches and the bytes/conditions they test, or explicitly record unresolved branches. Optional greeting/news remains deferred and separate from update-manifest acceptance. Do not replay proprietary manifest content.

Architecture Gate #2: **PASS carried forward**. Evidence Acquisition Gate: **OPEN**. Protocol Implementation Gate: **CLOSED**. E00 remains **PARTIAL**; this bounded result does not complete E01 or authorize account/game/database functionality.
