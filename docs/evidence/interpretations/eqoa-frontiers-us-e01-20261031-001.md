# E01 — guarded lab PNACH reaches the update-connection stage

Reviewed 2026-10-31, America/Chicago. Session `E01-20261031T115857739Z`; [sanitized manifest](../manifests/eqoa-frontiers-us-e01-20261031-001.json). Scope: this Frontiers US `SLUS-20744` / `EEEE1FCC` client in PCSX2 2.8.2.0, with the identified prepared card and experimental PNACH. No physical PS2 or cross-build result is implied.

**Result: PASS for one bounded compatibility experiment.** The client displayed DNAS Authentication **Status: Done**, advanced to **Connecting to update server**, and emitted TCP SYNs to **198.18.0.1:7000**. No TCP reply, completed handshake or application payload was captured; the client displayed an update error. This does not establish a working update/account/game service or complete E01/E02 acceptance.

## Authorization and E00 handoff

`NIGHTHAVEN DECISION`: the operator declined a third E00 network baseline and authorized moving into scoped E01 research with the existing N01/N02 evidence and its limitations retained. Full E00 remains PARTIAL; it was not retrospectively passed. The operator then explicitly requested inspecting the published PNACH, deriving a lab-specific candidate, one isolated harness validation and rollback. The newer supplied Box1 file was compared before proceeding.

One patched cold start was collected. There was no automatic extra baseline or unpatched control boot. The consent receipt records chat authorization and the scripted exact prompt response; the inherited runner label `interactive_exact_phrase` must not be interpreted as a newly typed operator response.

## Source provenance and selected changes

`CONFIRMED — reference`, scoped to external artifact bytes: the newer operator-supplied PNACH is 3,463 bytes, SHA-256 `01693f0235a74153e9d6ac075407c196968168b6dcf6dffa94f276fa45580fbb`. It matches the current [published Frontiers PNACH](https://eqoa.live/eeee1fcc.pnach), linked by the [installation guide](https://eqoa.live/install.html), and the previously registered October 25 static artifact. The earlier 1,478-byte supplied file has SHA-256 `bee3c4e892b6f83a7a8917425e2fc4b5a0337008ae9b47ab7c519b603c8d57aa`; it contains DNAS and graphics changes without resolver redirection.

The published file identifies Xylof but supplies no explicit license. Availability does not establish redistribution permission. External patch files and the source-informed experimental candidate remain operator-local, outside this repository. No clean-room provenance or permission to redistribute the source is claimed.

`NIGHTHAVEN DECISION`: the independently encoded candidate contains 28 instruction writes and nine guards: the conservative DNAS return/status surface plus an override of the identified shared resolver to numeric address `0xC6120001` (`198.18.0.1`). It excludes graphics changes, Station resource-name rewriting and the injected memory-card `SS` loader. It contains no revival-project endpoint. Candidate SHA-256: `94c406a3a4a6106d7cacc65af8b41d8aaae734da51ca05fa9ec42787bd101a82`.

The DNAS surface retains seven short zero-return paths and a status-output replacement writing three words at output offsets 0, 4 and 8; offset 12 is untouched. **UNKNOWN:** which individual stubs are necessary and the complete semantic meanings of the synthetic status values. This is a conservative candidate, not a proven smallest patch.

## Instruction, placement and guard verification

Static read-only inspection checked the original bootstrap ELF mapping and `UTIL.REL` export/code relationships. The candidate preserves the resolver prologue and epilogue; its branch at `0x00124B24` targets `0x00124B6C`. Its delay slot sets the return value to zero. Short DNAS returns likewise explicitly set zero in their delay slots; proxy paths preserve the original initial instruction. Write intervals are aligned and disjoint. Numeric address representation comes from original-library formatter evidence, not inferred packet byte order.

`CONFIRMED — reference`, scoped to [PCSX2 2.8.2 patch interpretation](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/Patch.cpp): continuous extended equality guards skip commands on failure. Descending skip counts cover all nested guards and writes. The original binding flag alone does not identify the dynamic module; unchanged UTIL instruction fingerprints are also checked. Resolver guards inspect unchanged original instructions. All guarded writes use the extended interpreter.

Seven bounded offline checks exercised instruction decoding, zero returns, exact status stores, resolver address/store/branch/epilogue behavior, each failed guard, complete successful application and repeated application. All passed. The separately versioned E01 harness passed 82 synthetic regression tests and package validation; elevated preflight then passed without a boot or networking changes. These checks do not establish runtime interoperability by themselves.

**UNKNOWN:** exact dynamic execution traces and whether every conditional write fired. PCSX2's log reports 37 active commands (28 writes plus nine guards), not proof that every guarded replacement executed. Runtime screen and packet evidence below establish only the observed outcome.

## Inputs and containment

The prepared input is the preserved output of corrected-DNS N02 session `E00-N02-20261031T031431295Z`, SHA-256 `e859bee1de08dcaa861c1f29aca1396f4a3f7b0a847eadc1a1d7243779d4c393`. It was read-locked and copied to a separate disposable `EQOA-E01-active.ps2`. The source, clean seed, previous working card, ISO and both supplied PNACH files remained unchanged. The saved network configuration was reused; no in-game network setup was needed in this run.

The only selected cheat directory was a fresh session-scoped directory containing the pinned candidate. Automatic patches and game fixes were disabled; nonempty per-game settings would block launch. Original cheat directories were untouched. No savestate was used.

Physical uplinks were temporarily disabled; TAP host `198.18.0.1/24`, guest `198.18.0.2/24`, gateway/DNS `198.18.0.1`. The existing local Technitium console supplied TAP-only, recursion-Deny fallback DNS and was restored afterward. It is not a Nighthaven dependency. No production adapter address, production DNS configuration or disk-encryption setting changed. The unavailable NAT-table provider remains UNKNOWN; independent routing-driver/service checks passed.

Capture readiness preceded guest launch by 1.477 seconds. The independent observer has 214 samples during the capture-start/collection interval, with both physical adapters administratively Down in every sample, no unsafe/missing samples and maximum sample gap 0.568 seconds. This is sampled containment evidence, not proof of all emulator flow coverage. Internal intercepted DHCP/DNS may be absent from TAP; semantic logs remain separate evidence.

## Observed timeline

Screenshot times are file-write observations, not exact transition clocks. Times below are UTC on 2026-10-31; the local date is also October 31.

| Observation | UTC | Classification |
|---|---|---|
| Capture ready | 11:59:44.084 | Harness evidence |
| Guest launched | 11:59:45.560 | Harness evidence |
| EULA | 12:00:32.796 | `CONFIRMED — client/protocol`, scoped screen observation |
| Network Connecting | 12:00:55.963 | Same scope |
| Network Connected | 12:01:02.601 | Same scope |
| Initializing Network | 12:01:08.933 | Same scope |
| DNAS Status: Done, two screenshots | 12:01:11.840; 12:01:12.858 | Same scope; not authentication against Sony infrastructure |
| First captured TCP SYN to lab port 7000 | 12:01:15.834 | `CONFIRMED — client/protocol`, scoped raw frame |
| Connecting to update server, two screenshots | 12:01:16.048; 12:01:16.928 | Scoped screen observations |
| Update error | 12:01:28.137 | Scoped screen observation |
| Collection after normal operator close | 12:01:37.250 | Harness evidence; 111.689 seconds after launch, not exact button time |

The 21 captured frames comprise six ARP frames, two host multicast UDP frames, four guest reverse-DNS questions, four local REFUSED replies and five guest TCP SYNs. The SYNs share a connection tuple and sequence value, have no payload, and target `198.18.0.1:7000`; observed timestamps are 12:01:15.834, 16.815, 18.819, 22.821 and 30.846. No TCP reply, DNAS-associated A query, game UDP exchange or IPv4 fragmentation was captured. The earlier N02 refusal baseline had DNAS-associated A queries and Error (-611).

`INFERRED`: the observed local TCP attempt belongs to the visibly contemporaneous update stage, and the compatibility candidate enables progression beyond the former DNAS blocker. DNAS and resolver behavior changed together; this is not a per-stub or single-variable causal experiment.

**UNKNOWN:** update application protocol, request path, expected response and content, whether HTTP is used, why no TCP reply was captured, and all account/game endpoint behavior. Port 7000 and the UI label do not establish HTTP. A later read-only check found no current TCP/7000 listener; that is not a measurement of listener/firewall state at every instant of the capture.

## Integrity and rollback

Independent review passed 92 manifest-reference checks: 61 top-level, 24 embedded run and seven embedded input checks. All 62 session files and three authorization/observer files remain EFS encrypted with Allow ACLs limited to operator/SYSTEM. Child ACLs inherit the restricted raw root; they are not individually described as protected. Nine screenshots were inspected. Raw bytes, cards, images, patch code, private paths and credentials are not imported into Git.

Normal operator close was recorded, with no forced exit. ISO, both original PNACH files, candidate and source cards retained their pinned hashes. The runtime INI equals the original snapshot and fail-closed restoration byte-for-byte, including cheats/networking disabled and the original cheat-directory selection. PktMon is stopped, PCSX2 and the temporary DNS console are closed, the original DNS service remains stopped, and physical administrative states are restored. A separate elevated read-only check reports `ROLLBACK_VERIFIED_NO_BOOT`. No additional unpatched boot was performed; the patched guest process and its RAM no longer exist.

## Next measurable action

Following review, the operator requested and explicitly approved a separate [receive-only probe](../experiments/E01-TCP7000-observation.md). Its [completed result](eqoa-frontiers-us-e01-tcp7000-20261031-001.md) establishes a handshake and one HTTP request; the HTTP uncertainty above describes this earlier SYN-only window. The next action is bounded update-response parser/no-update research. No application response, updater implementation or automatic rerun is implied. Full E01/E02, general compatibility, physical PS2 behavior and Protocol Implementation Gate remain open research / CLOSED implementation respectively.
