# Pass #5 — Client/Protocol Evidence Acquisition

Checkpoint date: 2026-10-25. Previous documentation review: d63bea28b198620bc2a1dfa44ae3640dfb84a5e6. Pass #5 has begun; Pass #6 and protocol implementation have not begun.

## Current result

The first checkpoint registers static observations of the operator-supplied Frontiers ISO, PNACH, original STATION.PAK, and EQOA memory card. These observations inform the experiments; they are not packet captures or completed E00/E01 results. No original-client wire fact is promoted to CONFIRMED — client/protocol.

The inspected bootstrap has PCSX2 ELF checksum EEEE1FCC. Its export table identifies the patched entry as sceInetName2Address. The replacement writes a constant result without selecting a hostname. The original network library's address-to-text implementation identifies the numeric value as **5.161.217.188**. Earlier analysis reversed its raw memory bytes; that interpretation and the local generator were corrected. The card independently stores that same dotted address in eqahosts.txt, a Station endpoint record, and a NewsURL setting.

The archive on the disc has 25 records; the card's archive has the same 23 UI XML payloads and two modified configuration payloads. Those strings are configured candidates, not observed connections. Named DNAS exports support a strong static mapping of the bypass targets. The additional hook requests the memory-card path BASLUS-20744EQONLINE/SS; no such file or ENC name was found in the examined directory slots. Runtime card mounting and actual file selection are not established by those observations.

## Evidence and limits

- [Static artifact manifest](evidence/manifests/eqoa-frontiers-us-static-20261025.json): identities, hashes, offsets, verification methods, and storage limitations.
- [Interpretation ledger](evidence/interpretations/eqoa-frontiers-us-static-20261025.json): bounded hypotheses and required experiments.
- [Candidate profile](evidence/profiles/frontiers-us-eeee1fcc-pcsx2-lab.md): partial E00 provenance and explicit missing fields.
- [E00/E01 run card](evidence/experiments/E00-first-baseline.md): isolated setup, three baseline runs, stop conditions, and promotion rules.

No proprietary images, game bytes, memory-card files, patch code, generators derived from the external patch, BIOS files, credentials, raw captures, or account/session values are imported into this repository. These records contain independent technical descriptions and fingerprints only. Raw source availability/access/encryption is recorded honestly; this checkpoint does not certify a capture storage arrangement that has not been configured.

The operator selected an isolated copy of the PCSX2 setup, including separate settings and memory card. The original ISO remains the unchanged input. The modified supplied card must not be described as a pristine card merely because cheats are disabled. The initial copied-card profile and a clean-card control must remain separately identified. Capture readiness and actual runtime outcomes are recorded separately from setup readiness.

MOTD page-format compatibility is deferred. No database, architecture, gameplay, DNAS service, or wire implementation decision is made by this checkpoint. Sandstorm remains external research context, not a Nighthaven endpoint or dependency.

## Offline readiness observation

The isolated PCSX2 2.8.2 UI was opened, and the operator selected and started the game. A frozen local log snapshot identifies SLUS-20744/EEEE1FCC, the cloned EQOA-working-copy.ps2 card, bootstrap execution, local DNAS crypto initialization, memory-card ENC path attempts, and a WORDS.TXT read from the card. This is one offline readiness/control observation with networking and patches disabled in the selected configuration. It is not a packet capture, completed E00, successful online DNAS authentication, or proof of Station archive selection. Metadata and log fingerprint are in [P00 observation](evidence/manifests/eqoa-frontiers-us-p00-offline-20261025-001.json); raw log bytes remain outside Git. Controller setup was handled separately by the operator.

## Private capture adapter installed

The operator approved installation of a verified signed TAP driver. TAP-Windows 9.27.0.0 is installed as Nighthaven E00 TAP, using the isolated host address 198.18.0.1/24. At the recorded 2026-10-25 setup checkpoint, DHCP, forwarding, default routing, DNS, bridging, and Internet Connection Sharing were checked; the relevant adapter isolation checks passed. These historical checks do not certify current guest containment or capture coverage; recheck both before each run. The unavailable native NAT provider was handled by separately verifying WinNat stopped, rather than assuming a missing provider means zero NATs. The virtual link is Always Connected so Windows can apply its active static configuration. Existing physical adapters and source emulator/card/BIOS files were not modified by the setup.

[Setup metadata](evidence/manifests/eqoa-frontiers-us-tap-lab-20261025.json) records this environment change. Exact device/package removal details and administrative logs remain in the local lab receipt. Retain the driver for upcoming captures; removal is deferred until the operator requests it. PCSX2 networking remains disabled, no capture has started, and E00 stays partial.

## Gate state

| Gate or experiment | State | Reason |
|---|---|---|
| Architecture Gate #2 | PASS carried forward | No architecture changes in this checkpoint. |
| Evidence Acquisition Gate | OPEN | Static observations registered; runtime collection remains necessary. |
| E00 | PARTIAL / NOT COMPLETE | Candidate media identity established; three captured cold starts and complete runtime/storage provenance are outstanding. |
| E01 | NOT RUN | Depends on E00 baseline and a controlled network/capture path. |
| E02–E11 | NOT RUN | Existing sequence and prerequisites remain in force. |
| Protocol Implementation Gate | CLOSED | No capture-backed framing/authentication/session evidence yet. |

Next: verify the isolated configuration and capture boundaries, finish the E00 profile, then collect three repeatable cold starts before the E01 timeline. A VM boot without raw guest/network evidence does not close E00. No live account login or revival-server interaction is part of that first baseline.
