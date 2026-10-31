# E00-N01 result — guest addressing, DNS and the DNAS screen

Collected/reviewed 2026-10-28 (America/Chicago); raw UTC date is October 29. **Network-path qualification: PASS for this run. Full E00 is not automatically closed.** [Sanitized manifest](../manifests/eqoa-frontiers-us-e00-n01-20261029-001.json) registers session `E00-N01-20261029T004029603Z`. Raw captures, client images, card/BIOS/configuration, logs and screenshots remain in restricted operator-local EFS storage outside Git.

## What was observed

The following `CONFIRMED — client/protocol` observations apply only to Frontiers SLUS-20744/EEEE1FCC running in PCSX2 2.8.2.0 with this operator-modified card and contained configuration. They do not establish physical PS2 behavior or compatibility across revisions.

- The guest emitted IPv4 traffic with source `198.18.0.2`. Emulator DHCP logs show Discover/Offer/Request/ACK, with that offered address and gateway/DNS `198.18.0.1`. Raw guest-source traffic supports address adoption; an offer alone was not used as proof. Internal DHCP remains semantic-log evidence, not a raw TAP exchange.
- The guest asked PTR questions for `2.0.18.198.in-addr.arpa`, followed by A questions for `gate1.us.dnas.playstation.org`. Each name was queried four times at each of two destinations: the legacy address `5.161.217.188:53`, then the lab resolver `198.18.0.1:53`. The local resolver returned eight DNS `REFUSED` replies under the intended deny-recursion configuration. No replies from the legacy destination were recorded.
- This is a deviation from the intended sole lab resolver: the effective guest DNS selection still includes the legacy address, although the DHCP ACK log advertises only the lab resolver. **UNKNOWN:** where the guest obtains that address and why it selects both. Static strings in the modified card are supporting context, not proof of the runtime selection mechanism. External physical links were disabled and host forwarding was disabled; the attempted legacy queries reached TAP, not the remote revival service.
- Screenshots show Play → **EQOA 2 / SCE/Ethernet (Network Adaptor)** → **DNAS Authentication: Connecting** → **DNAS Error (-611)** → Play. No successful DNAS authentication, account session or game connection is established.

**INFERRED:** denied name resolution is the immediate observed network blocker associated with the DNAS-stage error. A controlled differential is needed to establish the causal relationship and post-resolution behavior. The error code is recorded literally; no universal meaning for `-611` is asserted. **UNKNOWN:** original DNAS service address, transport/request/response, successful gate mechanism, required bypass/replacement behavior and later account/game exchanges.

## Timeline and capture boundary

All times below are UTC on 2026-10-29. Screenshot times are file-write times, not exact button presses or transition times.

| Evidence | Time / bounded result |
|---|---|
| Local DNS health check | 00:40:57; operator query for `capture.nighthaven.test` answered locally; not guest evidence |
| Capture ready | 00:40:59.637 |
| Emulator running | 00:41:01.066 |
| Play screenshot | 00:42:17.041 |
| Saved configuration screenshot | 00:42:24.240 |
| First DHCP-send log observed by helper | 00:42:35.200; timer proxy, not exact network activation |
| First PTR question | 00:42:40.283 to legacy DNS; local counterpart 00:42:46.304 |
| First DNAS-associated A question | 00:43:05.444 to legacy DNS; local counterpart 00:43:11.443 |
| DNAS Connecting screenshot | 00:43:15.766 |
| DNAS Error (-611) screenshot | 00:43:36.193 |
| Return to Play screenshot | 00:43:43.533 |
| Normal operator close / collection | Capture stopped around 00:43:49; `forced_exit=false` |
| Cleanup finished | 00:44:01.054; guest stopped, INI fail-closed, DNS and physical adapters restored |

There are **35 recorded Ethernet frames**: three host-origin multicast UDP frames, eight ARP frames, sixteen guest DNS questions and eight local DNS replies. The second rotated pcapng segment contains no packets and is retained. No TCP or other non-DNS application IPv4 attempt is recorded. TAP frames are authoritative for bytes visible at that boundary; emulator/DNS logs and screenshots are independently hashed supporting observations. DNS health checks, host multicast and guest traffic must not be conflated.

All **84 manifest file references** match recorded sizes/SHA-256; all **58 raw files** report EFS encryption. Pcapng structures and packet lengths are valid, conversion reports zero dropped packets, and PktMon reports no events lost. Those checks do not certify every possible emulator-internal flow. Exact button-input timing and original-hardware confirmation remain unavailable.

## Operational outcome

The final runner used an automatic local START after preflight, avoiding the earlier chat/elevation timing gap. DNS used the installed executable with an isolated operator-owned configuration, TAP-only port 53, loopback management, denied recursion and encrypted query logs. The original DNS Windows service stayed stopped. The live-log reader tolerated sharing locks; this run had no helper error and ended by normal operator closure within the approved bounds.

The prior aborted setup/boot attempts remain separate local artifacts. They are not counted as successful repetitions. Their corrections addressed UDP-socket classification, asynchronous listener rebinding, JSON timestamp comparison, append-only audit-log verification and live-log sharing. No DNAS patch, gameplay handler, application listener or database was implemented. No reference/client repository was changed.

## Acceptance and next evidence

E00-N01's address/first-request qualification is satisfied: actual guest IPv4 plus bidirectional local DNS and correlated client screens are present. The written full E00 gate still requires three comparable cold starts without configuration changes. This is **one** successful run under corrected settings; the earlier zero-address controls cannot silently be counted as three repetitions of this configuration. Remaining repeatability evidence or an explicit acceptance-criteria decision must be recorded before declaring full E00 complete. No additional run is authorized by this review.

The useful E01 target is now specific: how this profile resolves the DNAS-associated hostname and what it attempts after an appropriate controlled DNS answer. Design the next differential around that observed transition, retain Nighthaven-controlled endpoints and external containment, and vary one condition. Do not implement a DNAS bypass or imitate a successful DNAS response based on this refused-lookup capture. These are supporting E01 observations, not a completed E01 experiment. Architecture Gate #2 remains PASS; Evidence Acquisition OPEN; Protocol Implementation CLOSED.
