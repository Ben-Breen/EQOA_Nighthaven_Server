# Box1 loader tracing — preparation only

Prepared 2026-10-31 from `main` at `a9df44a`. **STAGED; NOT RUN.** No emulator, guest, debugger UI, packet capture or network experiment was started. No active Box1 or Nighthaven configuration, card, patch or ISO was modified. This is preparation for a separately approved guided comparison, not another passive packet-only run or a completed E01 result.

## Why different instrumentation is needed

The [U02 result](../interpretations/eqoa-frontiers-us-e01-u02-20261031-001.md) reaches Writing game data then black screen, without a later account-service connection in the capture. Network traffic alone cannot show every disc/card load or an in-process loader transition. Missing authentication service remains UNKNOWN.

**CONFIRMED — reference:** inspected PCSX2 source at commit `fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3` (tag 2.8.2) gates `TraceActive` on `PCSX2_DEVBUILD`; in other builds it is false. Its `MemCheck::Log` body is empty. Do not promise useful file tracing by merely enabling TraceLog keys or a memory-log checkbox. Binary compile flags were not independently proved from the version field; this preparation does not rely on those channels.

The same source supports file/EE/IOP console logging, timestamps and verbose console output, plus debugger execution breakpoints. These are diagnostics, not guaranteed complete filename/return-code coverage. The CLI `-debugger` intentionally opens the debugger and breaks at entry; `-logfile` selects the private log. Portable mode takes priority over custom data paths, so `-datapath` is not used to pretend Box1's portable profile has been redirected.

Primary sources: [debug/trace guard](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2/DebugTools/Debug.h), [memory log implementation](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2/DebugTools/Breakpoints.cpp), [logging configuration](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2/VMManager.cpp), [CLI](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2-qt/QtHost.cpp), [debugger import schema](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2-qt/Debugger/Breakpoints/BreakpointModel.cpp).

## Staged artifacts and preservation

Private EFS artifact `E01-TRACE-PREP-20261031T201055712Z` contains 16 files: original Box1 INI, original/working copies of both cards, working BIOS state, preserved Frontiers settings and published patch, inactive tracing INI, disabled debugger JSON/CSV, original-marker guards, provenance and inventory. Media/configuration bytes and operator paths remain outside Git. The [disabled recipe](../../../tools/ProtocolEvidenceLab/trace-recipes/frontiers-eeee1fcc-box1-disabled.json) contains independently authored debugger metadata only, not executable patch code or a runtime-validated trace fixture.

Private provenance SHA-256: `6bc1857eda7eb7bf86c3c072de31d97c0e1eceb29caf5d52bf9c4e90cd51b677`; inventory SHA-256: `cb152f15f49c1cb8fee0a951fc5af40593f6d0b2b924ec0b8fcb59ec04480226`. All 15 inventory references match actual sizes/hashes, and all 16 files remain in the restricted EFS bundle.

Five synthetic preparation tests pass: targeted duplicate section/key rejection, preservation of unrelated repeated cheat keys, no developer-trace enabling and the exact eight-column disabled import schema. Source before/after hashes match. The current Box1 INI differs from the earlier reference-capture fingerprint; the intervening cause is UNKNOWN. This preparation freezes the actual current closed profile instead of assuming the older hash. Nighthaven's restored profile remains unchanged.

The inactive overlay enables file/EE/IOP logs, timestamps, verbose console and standard-output routing. Logs/screens/debugger settings, cards, BIOS state, game settings, cheats and cache are directed to private staging. It must be applied only inside a future owned transaction that restores Box1's exact original INI. No active overlay is installed now. The private preparer intentionally has no launch/capture operation; the future capture/launch/rollback transaction must be reviewed before use. Existing reference-capture launcher pins must not be reused blindly with a changed INI.

## Checkpoints to validate at the next entry pause

All five recipe points are **disabled**. They are EE execution breakpoints, not automatic logging points. Their placement is source-informed from the unchanged published Sandstorm patch and pinned original bootstrap. No external loader code is copied or proposed for Nighthaven.

| EE address | Observation to collect | Qualification |
|---|---|---|
|`001016B8`|PC/registers and current instruction at common loader-hook site|Compare original or published-patched fingerprint; do not assume this always occurs after updating|
|`000FA048`|Arguments before external loader helper; bounded candidate string at a0 if valid|Specific to the external loader; exact API identity remains unverified|
|`000FA050`|v0 after that call and the subsequent branch|Published code tests a negative result; do not invent error meanings|
|`000FA068`|v0 after the next helper/header-read call|Byte/header/loader semantics require runtime corroboration|
|`001016C4`|PC/registers at common bootstrap resume marker|Placement confirmed; occurrence and semantic role in this run are not|

At initial debugger pause, verify active EEEE1FCC, EE context, exactly five imported disabled rows, logging destinations and guarded memory. Arm only the common marker after matching original/patched code; enable external-loader points only when the published loader words are present. Do not arm stale/unmatched addresses or turn every breakpoint on indiscriminately. Disable observed points as needed to avoid repeated pauses. If import/guards fail, stop before Play and preserve a preparation failure; do not spend another networking run hoping tracing worked.

For a hit, record UTC, current PC/ra/sp/a0–a3/v0–v1, active CRC, checkpoint identity and chronological relation to HTTP/update screens. Inspect at most 128 bytes at a valid filename-candidate pointer, and record the actual source prefix if readable. Do not dump entire RAM/code or label an arbitrary pointer as a filename. Keep debugger images and raw records private. Associate entry/return observations only when call/context evidence matches; register values alone do not prove successful decryption, loading or execution.

## Proposed guided run and stop conditions — not authorized by preparation

1. Obtain new explicit approval for one online Box1 comparison before any launch/capture. Keep the laptop online; leave the isolated Nighthaven profile untouched. Use the prepared working card/BIOS copies and original published patch configuration.
2. Review the actual apply/capture/restore transaction. Recheck source identities, private storage, idle capture and physical adapter mapping. Start narrowly scoped updater capture before launching. Record that this is filtered reference traffic, not complete client networking.
3. Apply only the staged diagnostic configuration, launch using native Windows paths and the verified `-debugger`/`-logfile` switches, then validate imports/guards while paused before Play. This initial pause is intentional and must be handled, not mistaken for a hung emulator.
4. Resume through EULA/Play/network selection. Collect a few targeted loader entry/return observations and timed screens; pause/continue through the debugger deliberately. Use the same checkpoint labels later for the lab where applicable; external-loader-only addresses do not transfer to unpatched code.
5. Stop before credentials at login/error or when the relevant transition evidence is collected. Bound the session to five minutes plus at most two minutes of documented debugger pauses; stop earlier after ten checkpoint hits or if the trace/guard budget is exceeded or new diagnostic output exceeds 256MiB excluding frozen source media. No automatic additional run. Pauses/cold private cache perturb timing; do not claim unperturbed retry measurements.
6. Close normally, stop only owned capture, preserve artifacts, restore exact original Box1 INI and prove source cards/patch/BIOS and Nighthaven profile unchanged. Keep the changed working card separately; never promote it into the original silently.

**Runtime validation remains NOT RUN:** actual debugger import, breakpoint hits, filename interpretation and post-update cause. Preparation does not authorize a later lab run or open broad protocol implementation. Acceptance for the next comparison is a supported entry/return/program-source observation around the transition, correlated with screens and HTTP, rather than merely reaching login again.
