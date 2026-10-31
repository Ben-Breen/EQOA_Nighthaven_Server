# E00-N02 result — controlled clean-card startup

Collected/reviewed **2026-10-30, America/Chicago**; UTC artifacts are dated October 31. Session `E00-N02-20261031T025049800Z`. **Controlled collection complete with limitations; full E00 remains partial.** The [sanitized manifest](../manifests/eqoa-frontiers-us-e00-n02-20261031-001.json) registers packet, log, screen, input and observer fingerprints. Raw evidence remains in operator/SYSTEM-only EFS storage outside Git.

## Inputs and actual procedure

The source was `E00-N02-Clean-Seed.ps2`, SHA-256 `f499d9b44baaa772b8c284f48b2ef5e421f8716140c1c9790ec08af0e197f9ee`. Before boot, the runner copied it to the disposable `EQOA-E00-active.ps2` and verified matching bytes. The seed remained protected and unchanged. The mounted working-card setting stayed unchanged throughout this run; emulator logs show one initial mount and subsequent normal saves, with no mid-run mount/configuration change. "Clean" is the operator's input designation, not independent proof of pristine historical content.

**Operator-reported context:** the seed did not already have the required configuration, so the operator ran the **EQOA Frontiers in-game network configuration tool during this captured session**, entering settings from memory. The game also prompted to prepare the memory card. These operations legitimately changed the working card's contents. They must not be confused with changing the mounted card. The saved output card is retained separately for future inspection; the immutable seed was not replaced with it.

The earlier `024349915Z` attempt started from the same correct seed copy, but the operator changed the selected card during execution after mistaking the working-copy filename for a different input. Its logs record ejection/reinsertion and a later access error. It is retained as an interrupted comparison attempt, not counted as this final controlled run. Earlier pre-boot failures are also separate. No original failed/collected artifact or completion evidence was overwritten.

## What the final recording establishes

The following **CONFIRMED — client/protocol** observations are restricted to Frontiers SLUS-20744/EEEE1FCC in PCSX2 2.8.2.0 and this card/configuration. They do not establish physical PS2 or other-revision behavior.

- Guest IPv4 source `198.18.0.2` appears on TAP. DEV9 logs separately show internal DHCP Discover/Offer/Request/ACK and a later Request/ACK. Internal DHCP is semantic-log evidence, not assumed to be visible as raw TAP packets.
- Seven guest DNS questions request `2.0.18.198.in-addr.arpa` (PTR): **four to `192.18.0.1:53` and three to `198.18.0.1:53`**. The intended lab resolver returns three `REFUSED` replies under the configured deny-recursion policy. No reply from `192.18.0.1` is recorded. Raw packets, DEV9 destination logs and the local DNS log agree on these observations.
- Six inspected native F8 images show the user agreement, memory-card preparation prompt, **EQOA 2 / SCE-Ethernet** profile, Connecting, Connected and Initializing Network. No DNAS success, account exchange or playable world is established.

**INFERRED:** the unexpected `192.18.0.1` destination is associated with the manually entered network configuration. The operator's explanation supports this interpretation. **UNKNOWN:** the exact saved field/slot that supplies it; saved network-profile fields were not decoded in this pass. The frozen emulator INI specifies DNS1 `198.18.0.1`, DNS2 `0.0.0.0`; that configuration alone does not prove the effective client resolver list.

No `gate1.us.dnas.playstation.org` question, query sent to the legacy resolver `5.161.217.188`, guest TCP or non-DNS application IPv4 is recorded in this bounded capture. Their absence here does not establish removal of dependencies or what a longer/corrected startup would do. This is not a causal proof that card changes alone explain the difference from [N01](eqoa-frontiers-us-e00-n01-20261029-001.md): input, manual setup, runtime preparation and observation window differ.

## Timeline and capture quality

All times below are UTC on 2026-10-31. Screenshot times are file-write times, not exact input/transition times.

| Milestone | Time |
|---|---|
| Capture ready | 02:51:20.218 |
| Guest launch | 02:51:21.557; capture ready 1.340 seconds earlier |
| User agreement screenshot | 02:52:10 |
| Memory-card preparation screenshot | 02:52:28 |
| First DHCP activity status recorded | 02:54:16.673; timer proxy |
| Saved network-profile screenshot | 02:55:07 |
| Connecting / Connected screenshots | 02:55:13 / 02:55:20 |
| Initializing Network screenshot | 02:55:25 |
| Collection | 02:55:48.456; 90-second network-phase limit, normal close, no forced exit |
| Restoration complete | 02:55:52.030 |

**Timing limitation:** the 90-second clock starts at the first observed DHCP-send log, not a confirmed press of Play/profile activation. Because the in-game configuration tool ran in this session, setup and measured connection timing overlap. Exact operator button timing and which DHCP exchange belongs to which UI action remain UNKNOWN. Do not interpret the stop as an independently measured client timeout.

The pcapng contains **30 Ethernet frames**: 12 host-origin UDP frames, eight ARP frames, seven guest DNS questions and three local DNS replies. Host traffic is present; this is not guest-only capture. The empty second rotated segment is retained. Conversion reports zero packet drops; PktMon reports no events lost. These checks do not prove visibility of every emulator-internal path.

Integrity review verified **85 top-level manifest references**, or **106 checks including embedded run references**, with zero size/hash mismatches. These are repeated references to files, not 106 unique artifacts. The session has **58 raw files**, all EFS encrypted with operator/SYSTEM-only Allow ACLs. All six screenshots were visually reviewed. The offline decoder and interpretation assumptions are identified in the manifest; raw capture bytes remain authoritative.

## Isolation, recovery and outcome

The independent read-only adapter observer recorded 477 samples. All **416 samples during capture/guest operation** show both physical adapters administratively Down; maximum overall sampling gap was about 1.363 seconds. The existing TAP/routing checks also passed. Sampled state is supporting operational evidence, not a claim of continuous all-flow or original-hardware coverage.

Guest stopped normally; the fail-closed INI was restored, original DNS service remained Stopped, temporary DNS was removed, and the saved physical adapters were restored. Current checks found Wi-Fi Up, PCSX2 closed and `EthEnable=false`. Seed hash remains unchanged. The authorization receipt records the explicit user-approved one-run handoff; the runner's fixed `interactive_exact_phrase` label is qualified there as a scripted response to chat authorization.

The networking update/reboot and bringing the disabled TAP back up preceded this run. This run passed the previous post-disable guard, but the exact cause of the earlier failure is still UNKNOWN; there was no per-adapter failure-time snapshot in that older attempt. Do not claim the update is a proven root-cause fix.

**NIGHTHAVEN DECISION:** retain this as one useful, controlled clean-card collection with an explicit DNS-address mismatch and timing limitation. It is not an unchanged-profile N01 repetition, a complete DNAS differential, full E00 acceptance or E01 completion. Architecture Gate #2 remains PASS; Evidence Acquisition OPEN; Protocol Implementation CLOSED.

Next measurable action: inspect the retained output card's saved network configuration without altering it, identify the unexpected DNS address and produce a separately versioned/hash-recorded corrected working input. Separate setup from the measurement window and record actual profile activation before any later authorized capture. No further run, DNAS behavior change, server implementation, commit or push is authorized by this record.
