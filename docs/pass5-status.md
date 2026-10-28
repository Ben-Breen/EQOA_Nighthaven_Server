# Pass #5 — Client/Protocol Evidence Acquisition

Checkpoint date: 2026-10-25. Previous documentation review: d63bea28b198620bc2a1dfa44ae3640dfb84a5e6. Pass #5 has begun; Pass #6 and protocol implementation have not begun.

Latest review: 2026-10-28 (America/Chicago). Three offline-control repetitions are now collected and reviewed; full E00 remains incomplete. Earlier sections retain their dated checkpoint context.

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

## 2026-10-27 E00 preparation update

The exact portable profile and configuration hashes are now identified in the [candidate profile](evidence/profiles/frontiers-us-eeee1fcc-pcsx2-lab.md). Operator execution verified an elevated capture context, TAP component enumeration, and a separate EFS-encrypted raw directory with operator/SYSTEM-only access. An initial helper overstated NAT verification after an unavailable query; the original output is retained with a correction and independent stopped-driver/service observations. A preparation boot without capture was closed normally and is excluded from R01–R03; the approved original card is still available for fresh clones.

The [run card](evidence/experiments/E00-first-baseline.md#tap-capture-boundary--source-evidence-runtime-result-still-unknown) records a new PCSX2 source finding: internal DNS can use the host resolver before TAP output, and intercepted DHCP/DNS can be invisible to TAP capture. Stopping the wildcard Technitium listener is authorized, including restoration, but does not by itself close the host-resolver path. A bounded fully offline operator session is being prepared; temporary host-network interruption requires separate authorization. No baseline capture or network-disconnection action has occurred. E00 remains incomplete and E01 has not started.

## 2026-10-28 E00 collection review

The operator collected session `E00-20261028T010947216Z`: R01–R03, all explicitly **fully offline modified-card controls**, with capture before boot, fresh frozen inputs and normal closure. [Sanitized manifest](evidence/manifests/eqoa-frontiers-us-e00-offline-20261028-001.json) and [review](evidence/interpretations/eqoa-frontiers-us-e00-offline-20261028-001.md) register raw hashes and 14 reviewed screenshots. All 135 manifest references match actual sizes/hashes; all 73 raw files report EFS encryption and operator/SYSTEM-only Allow ACLs. No raw bytes, logs, screenshots, card/BIOS content or credentials were added to Git.

All three show EULA, the saved PS2 network configuration **EQOA 2** and a later failure/disconnected result. Twenty host-source UDP frames appear in R01; one non-host-source ARP request appears in each run. Guest origin is INFERRED, full guest/DNS visibility is UNKNOWN, and no EQOA opcode or endpoint requirement is established. This is a TAP-component capture with host traffic, not proven guest-only coverage. Exact button-input timing and some intermediate screenshots were not collected.

The helper recorded full restoration at `01:20:20Z`; the later recovery attempt made no changes and incorrectly threw on an already-restored state. That reporting bug was corrected locally and isolated branch/syntax checks passed; no guest rerun is needed for it. The latest review confirms PCSX2 closed, fail-closed INI and administratively enabled physical adapters. Technitium now reports Stopped, differing from the earlier restoration observation; the intervening cause is UNKNOWN. No current network/service state was changed during this review.

## Current gate state

| Gate or experiment | State | Reason |
|---|---|---|
| Architecture Gate #2 | PASS carried forward | No architecture changes in this checkpoint. |
| Evidence Acquisition Gate | OPEN | Static evidence and reviewed offline-control collection registered; further targeted observation remains necessary. |
| E00 offline control R01–R03 | COMPLETE, scoped control only | Repetitions, integrity and screen/packet review complete; normal online startup and all-flow visibility are not established. |
| E00 | PARTIAL / NOT COMPLETE | Required DNS/all-flow coverage and normal destinations remain unestablished; exact input timeline and acquisition provenance are incomplete. |
| E01 | NOT RUN | Depends on E00 baseline and a controlled network/capture path. |
| E02–E11 | NOT RUN | Existing sequence and prerequisites remain in force. |
| Protocol Implementation Gate | CLOSED | No capture-backed framing/authentication/session evidence yet. |

Next: execute the prepared [E00-N01 contained network-startup card](evidence/experiments/E00-N01-contained-startup.md) only after the operator authorizes its bounded DNS/network changes and one captured boot. The plan uses TAP host/DNS `198.18.0.1`, guest `198.18.0.2/24`, explicit nonzero DHCP settings and existing DNS/DHCP logging. It includes permitted traffic, stop timers, capture limits and rollback; preparation changed no runtime settings and produced no new capture. Preserve the completed controls; a changed-profile qualification run does not automatically close full E00. Proceed by investigating the next observed blocker toward E01, rather than broad speculative research or an instrumentation framework. DNAS compatibility remains open; no game service, database or wire implementation is introduced.
