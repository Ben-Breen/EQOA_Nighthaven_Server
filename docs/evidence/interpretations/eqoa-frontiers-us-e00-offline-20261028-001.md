# E00 review: three fully offline modified-card controls

Reviewed 2026-10-28 (America/Chicago). Collection took place on October 27 local time, `2026-10-28T01:09:47Z`–`01:20:20Z`. [Sanitized manifest](../manifests/eqoa-frontiers-us-e00-offline-20261028-001.json) identifies the restricted evidence by SHA-256. Raw ETL, converted pcapng, logs, screenshots, settings and card/BIOS files remain outside Git.

**Result:** R01–R03 are reviewed, completed repetitions of the explicitly named fully offline modified-card emulator control. **E00 remains PARTIAL / NOT COMPLETE** under the existing [E00 criteria](../../protocol-evidence-plan.md#e00--client-profile-and-clean-baseline). DNS/all-flow visibility and normal startup destinations have not been established. E01 is NOT RUN; the Protocol Implementation Gate remains CLOSED. Do not repeat these three controls because of the recovery warning, or silently relabel them an online/pristine baseline.

## Provenance and integrity

- Same PCSX2 2.8.2.0 executable, SLUS-20744/EEEE1FCC client profile and approved modified-card seed. Each run restored a fresh active card and isolated BIOS/sidecars from the preserved inputs. All three INI input hashes are `252482c278140459c39191bdf5b5db6d040891a47229443b3cda0a49631a0b2d`; their output INIs match. Card output hashes differ from the input; no semantic interpretation of those writes is established. BIOS/sidecar outputs match their respective inputs.
- Settings selected TAP, the dedicated `Nighthaven E00 TAP` interface, networking enabled for the run, cold boot, and cheats/patches/game fixes disabled. Configuration and logs support the selected setup; they do not independently prove the selected backend captured every guest request. The supplied card remains modified.
- Operator authorized the temporary host-network interruption and Technitium stop/restoration. Saved adapter inventories record physical links disabled while TAP remained available; preflight recorded no TAP default route/DNS/native forwarding/bridge/port proxy. The unavailable NAT-table provider remains UNKNOWN; stopped WinNAT/ICS/RRAS checks are separate observations. PCSX2 inherited the elevated operator token in this session; this is lab provenance, not an architectural requirement.
- Read-only review verified **135 file references**, including duplicated references across manifests, against actual SHA-256 and size: **zero mismatches**. All **73 raw session files** report EFS encryption; no file Allow ACL grants an account other than the operator or SYSTEM. The raw root has inheritance disabled. This uses folder/file encryption; no BitLocker enablement was performed.
- Capture-ready events precede each emulator-running event. All three run results record normal closure (`forced_exit=false`). PktMon stop reports no events lost; conversions report zero dropped packets. Pcapng block lengths/trailers are valid, link type is Ethernet, and recorded lengths are not truncated. Those checks apply to recorded events and cannot establish visibility of traffic intercepted before TAP.

## Observed screens and timing

Times below are UTC file-write times of reviewed F8 screenshots, rounded to seconds. They bound visible observations, not exact button presses, transition times or network timeouts. Full hashes and finer timestamps are in the manifest.

| Run | Capture ready | Emulator running | Screens retained, in order | Last failure screenshot; time since running event |
|---|---|---|---|---|
| R01 | 01:09:53.920 | 01:09:54.228 | EULA; modified-card preparation notice; Play; saved network configuration; failure/disconnected | 01:14:03.894; about 250 s |
| R02 | 01:14:28.890 | 01:14:29.070 | EULA; modified-card preparation notice; saved network configuration; failure/disconnected | 01:17:19.855; about 171 s |
| R03 | 01:17:46.245 | 01:17:46.394 | EULA; Play; saved network configuration; connecting; failure/disconnected | 01:20:03.492; about 137 s |

All three show saved PS2 configuration **EQOA 2** and device **SCE/Ethernet (Network Adaptor)**. Those game labels are distinct from the Windows TAP interface name. No successful account/game session is established by these screens. Not every intermediate screen has a screenshot in every run. Operator notes are sparse; an exact input timeline was not collected. Different elapsed observation times therefore do not establish differing protocol timeouts.

The recorded DEV9 INI has `EthEnable=true`, `EthApi=TAP`, `InterceptDHCP=true`, and `PS2IP`, `Mask`, `Gateway`, `DNS1`, `DNS2` set to `0.0.0.0`, with automatic mask/gateway enabled. These are emulator configuration values, not observed effective guest addresses. Whether zero values select automatic behavior, are ignored by this path, or require correction remains UNKNOWN here. Inspect the effective guest address/DNS configuration in the next targeted attempt; do not assume an IPv4 assignment or infer the cause of the failure from these values alone.

## Packet observations and interpretation

| Converted artifact | Recorded frames | Bounded observation |
|---|---:|---|
| R01/capture1.pcapng | 21 | Twenty IPv4/UDP frames with Ethernet source matching the host TAP interface; one broadcast ARP request from another source. |
| R01/capture2.pcapng | 0 | Empty packet segment retained; not a missing capture file. |
| R02/capture1.pcapng | 1 | One broadcast ARP request matching the non-host pattern in R01. |
| R03/capture1.pcapng | 1 | One broadcast ARP request matching that pattern. |

The three ARP requests have zero sender/target IPv4 values. Their packet timestamps are `01:13:17.422Z`, `01:16:20.188Z` and `01:19:19.654Z`, after the respective network-selection screenshots. Addresses and payload bytes remain restricted. No EQOA message is identified from these frames.

- **INFERRED:** the non-host-source ARP requests originate from the guest/emulator path, based on repeatability, screen/log correlation and source distinct from the host TAP MAC. The evidence does not independently bind that source to an original PS2 network stack.
- **UNKNOWN:** complete guest traffic, actual DNS/DHCP calls handled internally, ordinary online destinations, cause of the generic failure, DNAS gate behavior, authentication or session semantics. Absence of a DNS packet on TAP is not evidence of absence of a resolver call.
- **CONFIRMED — reference**, scoped to official PCSX2 source rather than EQOA: the versioned [TAP/common-handler/DNS references](../experiments/E00-first-baseline.md#tap-capture-boundary--source-evidence-runtime-result-still-unknown) establish a possible pre-TAP interception path. **INFERRED:** correspondence to the local version-matched executable; its use in these runs is UNKNOWN.

Artifact verification and visible observations above are scoped to this emulator, modified card and offline environment. No EQOA field, opcode, endpoint requirement, DNAS response or original-hardware behavior is promoted to `CONFIRMED — client/protocol` by this review. TAP component selection also collected host frames; it is not proven guest-only capture.

## Restoration and recovery warning

The saved session finished at `01:20:20.356Z` with guest stopped, INI fail-closed, DNS restored and physical adapters restored. Subsequent inspection corroborated DNS running at that earlier review checkpoint. The operator's recovery attempt at `01:20:52.174Z` found that completed state and changed nothing; the old helper incorrectly threw on that harmless result. Its original script/report were preserved locally. The corrected helper reports `ALREADY_RESTORED`; syntax and isolated no-op branch checks passed. It was not necessary to rerun recovery or any guest.

At the later `2026-10-28T06:13:56Z` review, PCSX2 is closed, physical adapters are administratively enabled and the INI matches saved fail-closed SHA-256 `840e9039ed19f7b8a956b0702eba6106cafc287b9b0121d2b749ac02b63ded80` (`EthEnable=false`, `EthApi=TAP`). Technitium currently reports **Stopped**, differing from the earlier restoration observation; the intervening cause is UNKNOWN. The collection record is historical evidence, not a guarantee of current service state. No service, adapter or capture state was changed in this read-only review.

## Acceptance gaps and next action

The offline-control repetitions and integrity review are complete. Full E00 is not closed: all-flow/DNS coverage is unqualified, normal destinations are unobserved, precise input timing is absent, and acquisition provenance remains operator context. Keep these records; any further run must answer a specific gap rather than recollect the same failure without improved observability. The operator's 2026-10-28 steering favors a targeted network-startup test over more unchanged offline runs or an extended capture-tooling project.

**One measurable next action:** prepare one contained network-startup run card. Preparation is complete when it names the selected saved PS2 configuration and guest IPv4/subnet/gateway/DNS values (or the exact automatic-configuration settings), identifies the Nighthaven-controlled network path and allowed endpoints, and states the TAP/internal-handling capture boundary, start-before-boot procedure and stop condition. Check these specific prerequisites; do not repeat the completed three-run control or require a broad instrumentation framework first. This preparation needs no guest boot.

The resulting authorized attempt should capture address-assignment/first-connection evidence and client-screen timestamps, using existing emulator logs where informative. A hidden DNS/DHCP path must be documented and targeted if it prevents attribution; TAP alone must not be called complete coverage. Successful guest IPv4 configuration does not itself establish endpoint reachability or DNAS behavior. DNAS compatibility may be necessary, but the current failure does not establish the gate or the mechanism; no bypass is selected or implemented by this review. Do not route to another revival project's service merely because the modified card names it. Recheck current DNS/capture state before the run and stop before credentials or an unapproved destination.

The next attempt targets the remaining E00 network-evidence gap; only after baseline prerequisites are met does collection proceed as E01 bootstrap/DNAS observation, followed by E02 differential research. No gate is closed by preparation alone. No server functionality, DNAS implementation or guest run is part of this documentation review.
