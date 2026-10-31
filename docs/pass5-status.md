# Pass #5 — Client/Protocol Evidence Acquisition

Checkpoint date: 2026-10-25. Previous documentation review: d63bea28b198620bc2a1dfa44ae3640dfb84a5e6. Pass #5 has begun; Pass #6 and protocol implementation have not begun.

Latest review: 2026-10-30 (America/Chicago). Two N02 **offline clean-card collections** are reviewed alongside N01: an earlier setup/address-mismatch control and a corrected-DNS run under a five-minute policy. The N01/N02 comparison is complete within its bounded scope; full E00 remains incomplete. The earlier proposed online-host repetitions are a different scope and remain unrun. Earlier sections retain their dated checkpoint context.

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

## N01 corrected-address/DNS result — 2026-10-28 local time

[N01 result](evidence/interpretations/eqoa-frontiers-us-e00-n01-20261029-001.md) and [manifest](evidence/manifests/eqoa-frontiers-us-e00-n01-20261029-001.json) register session `E00-N01-20261029T004029603Z`. The run closed normally with five screenshots; all 84 manifest file references match hashes/sizes and all 58 raw files report EFS encryption. Guest IPv4 `198.18.0.2` and bidirectional local DNS are established for this emulator profile. The capture also shows queries to the legacy DNS address, with no external reply; the effective selection mechanism is UNKNOWN. Local DNAS-associated hostname queries received REFUSED, and the client displayed DNAS Error (-611). This identifies an E01 research target, not a successful DNAS exchange or a proven bypass requirement. Temporary DNS, capture, INI and adapter states were restored. Earlier failed attempts remain separate and do not count as repetitions.

## 2026-10-29 online-host containment qualification

The operator requested two unattended repetitions while keeping the laptop online. A [synthetic host-resolver test](evidence/interpretations/e00-online-host-resolver-boundary-20261029.md) first checked the proposed executable-only firewall boundary: both positive controls produced five TAP-local DNS queries, and the firewall-blocked phase also produced five. This is a host-runtime counterexample to that boundary, not a client/protocol fact or an external-delivery observation. Cleanup was recorded and checked; Wi-Fi remains up, PCSX2 is closed with networking disabled, and the temporary rules were removed. N02/N03 were not started. Stronger online-host containment remains a prerequisite; no DNAS/game implementation or architectural change follows from this result.

## 2026-10-30 earlier N02 clean-card collection

[Earlier N02 result](evidence/interpretations/eqoa-frontiers-us-e00-n02-20261031-001.md) and [manifest](evidence/manifests/eqoa-frontiers-us-e00-n02-20261031-001.json) register `E00-N02-20261031T025049800Z`. The clean seed was cloned to the disposable working card; the source remained unchanged and the mount stayed stable. Six F8 images, guest IPv4, seven PTR questions and three local REFUSED replies are recorded. Queries went to `192.18.0.1` as well as intended `198.18.0.1`. The operator reports running the EQOA Frontiers in-game network configuration tool during capture, entering settings from memory. The exact saved DNS field is not decoded. The first-DHCP timer therefore cannot be equated to the later Play/profile activation.

The 90-second network-phase limit closed the guest normally. All 85 top-level manifest references (106 checks including embedded run references) match; all 58 session raw files remain EFS encrypted with restricted Allow ACLs. All 416 adapter samples during capture show both physical adapters Down; capture preceded launch and restoration passed. Prior pre-boot failures and the interrupted card-switch attempt remain separate. This is a scoped collection, not a same-profile N01 repetition, successful DNAS exchange or completed E01. No further run was started.

## Later October 30 N02 — corrected DNS and comparison

The later [manifest](evidence/manifests/eqoa-frontiers-us-e00-n02-20261031-002.json) registers `E00-N02-20261031T031431295Z`. The operator requested a five-minute window or earlier normal close. A separate v3 lab bundle passed 74 offline regression tests and removed the DHCP-based stop condition; existing isolation/recovery checks were retained. This run closed normally before the 300-second maximum. Eight screenshots, 30 frames, 89 top-level reference checks (112 including embedded run references), 60 encrypted restricted raw files and 350 safe capture-interval adapter samples are reviewed.

The [N01/N02 comparison](evidence/interpretations/e00-n01-n02-comparison-20261030.md) shows the latest N02 queried only `198.18.0.1`, asking both the PTR and DNAS-associated A question; N01 also queried the legacy resolver. Both received eight local REFUSED replies and reached DNAS Error (-611). The corrected-DNS run does not establish a successful DNAS exchange or a single-variable cause. The earlier N02 control is preserved, the seed remains unchanged, the mount stayed stable and restoration passed. No additional live run followed.

## October 31 E01 — lab PNACH and update-stage observation

The operator authorized a scoped E01 handoff using the existing N01/N02 evidence, retaining full E00's repeatability/provenance limitations and declining a third network baseline. The newer supplied PNACH matches the published artifact already registered in the static evidence. An independently encoded, guarded lab candidate omits the resource rewrite, memory-card loader and graphics changes; its source-informed provenance and unproven per-stub necessity remain explicit.

The [E01 review](evidence/interpretations/eqoa-frontiers-us-e01-20261031-001.md) and [manifest](evidence/manifests/eqoa-frontiers-us-e01-20261031-001.json) register one authorized session, `E01-20261031T115857739Z`. Nine screenshots show DNAS **Status: Done**, update connection and an update error. The 21-frame TAP capture includes five SYN attempts to `198.18.0.1:7000`, with no TCP reply or application payload. HTTP and the missing-response cause remain UNKNOWN. This is scoped client/emulator evidence, not Sony authentication, a working service or proof that every patch write executed.

Seven bounded candidate checks and 82 offline harness tests passed before elevated readiness and the captured run. The prepared corrected-DNS N02 output was copied to a distinct disposable card. All 92 manifest-reference checks pass; 62 session files and three authorization/observer files remain restricted and EFS encrypted outside Git. Normal closure and a separate elevated read-only check verify rollback: original INI restored byte-for-byte, cheats/networking disabled, capture stopped, original DNS state and physical adapters restored, source ISO/cards/PNACH files unchanged. No additional unpatched boot occurred. Patch code, assets and raw captures remain outside the repository.

## October 31 E01 — receive-only TCP/7000 observation

After explicit new-run approval, session `E01-TCP-20261031T122522344Z` used the same prepared input and PNACH with one TAP-bound, guest-only receive tool. Its [result](evidence/interpretations/eqoa-frontiers-us-e01-tcp7000-20261031-001.md) and [manifest](evidence/manifests/eqoa-frontiers-us-e01-tcp7000-20261031-001.json) record a completed TCP handshake and a 104-byte HTTP/1.1 GET for `/patch/eqoa/eqoa-frontierslive-update.xml.gz`. The socket destination is `198.18.0.1:7000`; the legacy domain remains only in the observed Host field. Listener bytes match the raw TCP payload. No application response was sent; an acceptable empty body or update manifest remains UNKNOWN.

Four screenshots, 26 frames, 92 reference checks, source preservation and normal closure are reviewed. All raw artifacts remain restricted/EFS outside Git. The listener/rule were removed before restoring uplinks; a separate elevated read-only check verifies their absence, idle capture and exact original-profile rollback. Ten receiver checks and 103 offline integration tests preceded the run. This is a completed bounded observation, not an updater or playable server. News/greeting behavior remains optional and deferred.

## Current gate state

| Gate or experiment | State | Reason |
|---|---|---|
| Architecture Gate #2 | PASS carried forward | No architecture changes in this checkpoint. |
| Evidence Acquisition Gate | OPEN | Static evidence and reviewed offline-control collection registered; further targeted observation remains necessary. |
| E00 offline control R01–R03 | COMPLETE, scoped control only | Repetitions, integrity and screen/packet review complete; normal online startup and all-flow visibility are not established. |
| E00-N01 network qualification | PASS, one run | Guest address adoption and DNS exchange captured; client reaches the DNAS screen. Internal DHCP remains semantic-log evidence. |
| October 29 proposed online-host N02/N03 | NOT RUN / BLOCKED | Separate from the later offline clean-card N02. Executable-only resolver containment failed; a stronger boundary is required for an online host. |
| E00-N02 offline clean-card collection/comparison | COMPLETE, scoped observations only | Earlier setup control plus corrected-DNS run retained separately; latest run has stable working card, eight images and DNAS-stage DNS/error. No DNAS success or causal proof. |
| E00 | PARTIAL / NOT COMPLETE | N01 qualification and separate N02 clean-card evidence do not satisfy three unchanged-profile cold starts. Timing, acquisition provenance and capture blind spots remain limitations. |
| E01 | PARTIAL; two scoped observations reviewed | DNAS Done, lab TCP/7000 and one HTTP request observed. Accepted response, full dependency timeline and per-change differential remain open. |
| E02–E11 | NOT RUN | Existing sequence and prerequisites remain in force. |
| Protocol Implementation Gate | CLOSED | No capture-backed framing/authentication/session evidence yet. |

Next: inspect the original update-response parser/no-update acceptance conditions and specify an independent candidate response with explicit unknowns. Any response experiment requires new authorization. The operator-directed E01 handoff retains E00 limitations; these results do not pass full E00 or authorize an updater, account/game/database services or broad wire implementation.
