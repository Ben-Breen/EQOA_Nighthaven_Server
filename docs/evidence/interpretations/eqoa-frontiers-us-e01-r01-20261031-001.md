# E01-R01 — loader comparison and guarded resource candidate

Reviewed October 31, 2026 (America/Chicago), from `main` at `e2c7575`. [Manifest](../manifests/eqoa-frontiers-us-e01-r01-20261031-001.json). **One authorized collection completed; candidate effect INCONCLUSIVE; account-login goal incomplete.** UTC session `E01-R01-20261101T020048844Z` falls on November 1; the local experiment date is October 31. No automatic second run occurred.

## Offline comparison

**CONFIRMED — reference**, specifically static operator-media/published-patch evidence, not observed execution or a historical-server requirement:

- The original bootstrap ELF has separate `Station__10VILauncher` and `Client__10VILauncher` exports at `00101648` and `001016B8`. Its relocation records associate calls at `0010169C` and `001016C4` with `station_main` and `client_main`, respectively. The on-disc zero-target calls are link placeholders, not evidence that runtime calls jump to zero.
- The published injected hook targets the Client wrapper, not the separate Station wrapper. Original main code calls the Station wrapper, tests its result, and on the continuing path loads CLIENT before calling the Client wrapper. This establishes static order; actual execution through these markers remains UNKNOWN.
- The original loader constructs card `%s.ENC` and disc `%s.AUT` paths, with a disc fallback on the inspected file-open path. Decryption, unpacking and module initialization are separate operations. Do not replace them with an assumed successful return.
- A read-only FAT/directory traversal of the frozen successful Box1 input and working cards finds `SS`, `S2`, `station.pak`, and endpoint configuration. The prepared lab input and R01/P01 comparison baseline do not have those replacement files or cached `.ENC` modules. This is allocated-directory evidence, replacing earlier inconclusive substring searches; it does not establish file execution or necessity. The parser does not verify/correct ECC.
- The original ISO already contains root `STATION.PAK` (82,094 bytes) and account/login UI identifiers. Its contents were inspected in place, not extracted into Nighthaven. The Box1 card pack differs; neither its contents nor its loader were imported.

**INFERRED:** investigate original Station resource selection before recreating the external Client hook. A full loader recreation is not justified by these observations. Original account-screen timing and the actual Station resource address in the lab remain UNKNOWN.

Sources: original bootstrap SHA-256 `40909bc57f83be237a5dbbaef1ca935c98188fddfa4ffc715039e1d3307fdcd2`; [published patch](https://eqoa.live/eeee1fcc.pnach), previously frozen SHA-256 `01693f0235a74153e9d6ac075407c196968168b6dcf6dffa94f276fa45580fbb`; [Ross Ridge's card-format research](https://github.com/PCSX2/myMCpp/blob/master/docs/memcard.md). Static artifact evidence does not become CONFIRMED — client/protocol wire semantics.

## Focused candidate and instrumentation

**NIGHTHAVEN DECISION:** test one independently authored filename-selection hypothesis with the same prepared card, updater responses and receive-only account probe as P01. The prior 28 instruction writes remain unchanged. Three additional **data** word writes attempt to replace a fully matched `/station.pak` plus NUL with `STATION.PAK` plus NUL at the published resource-change address `003635A0`. Six halfword guards and one byte guard check all 13 expected bytes; any mismatch skips all three writes. No injected instructions, external loader, downloaded resource or authentication reply is added.

The complete old filename and its placement were **UNKNOWN**, inferred beyond the published two-byte `/s` guard. Relative-name lookup selecting the original disc resource was also a hypothesis. These were deliberately testable guesses, not confirmed requirements. The candidate remains private, SHA-256 `d712ff9a8f7e4b6696859a7339e6765a3a6723ea1ffcfe5638901e8eaf585b7d`.

Seven resource guard tests, seven existing instruction/control-flow tests, 110 harness regressions and eight in-memory observer tests pass. They establish bounded encoding/guard behavior, not client acceptance. [PCSX2 Patch.cpp](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2/Patch.cpp) supports the conditional-code interpretation.

Temporary profile-only PINE instrumentation uses the emulator's Windows localhost binding. The observer verifies listener PID/start identity and CRC, allows only CRC lookup and reads of this fixed 13-byte slot, and sends no write commands. It records hashes/classifications on change, not a RAM dump. This emulator host interface is separate from EQOA networking. [PCSX2 PINE.cpp](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2/PINE.cpp) documents the inspected implementation; actual endpoint ownership was checked during collection.

## Observed result and limits

**CONFIRMED — client/protocol, modified Frontiers US / PCSX2 2.8.2.0 environment only:** the TAP capture has 56 frames, including 31 TCP frames, all using server port 7000. Server payload totals 543 bytes and client payload 220 bytes. The unchanged updater delivered 307-byte manifest and two 118-byte Changes responses. The ready TCP9735 probe reports NO_CLIENT, zero received bytes and zero application response bytes. No account exchange was captured.

The operator reports **Loading followed by a memory-card loading box**. No screenshots were collected. This does not establish account login, correct resource loading, or improvement over the earlier visual progression.

The emulator observer collected **441 samples and six distinct observed states**. Neither the hypothesized old token nor the replacement token was observed. **The candidate's application/effect is NOT ESTABLISHED.** Sampling cannot rule out transient values. Do not interpret this as a negative test of a correctly applied resource change, relax the guards blindly, or repeat the same candidate unchanged.

An instrumentation limitation matters: unrecognized bytes were retained only as hashes. They cannot supply the actual filename by themselves. Offline matching identifies the initial all-zero state and one 13-byte match within original SUPPORT.AUT; it does not resolve the final slot or prove module execution. A future, uninstalled observer preparation now preserves the same bounded bytes privately. The frozen v6 runner and original R01 evidence remain unchanged; no new experiment followed this correction.

All **95 recorded artifact references** verify. The reviewed session has 86 restricted/EFS files, including frozen tools; authorization/observer evidence has five. All 223 physical-adapter samples in the reviewed guest interval show administrative isolation without observer errors; this is sampled evidence, not a universal coverage claim. Independent elevated verification at `2026-11-01T02:06:20Z` confirms normal closure, exact original INI, networking/cheats/PINE disabled, capture stopped, no 7000/9735/28121 listeners, temporary firewall removal, and DNS/physical-adapter restoration. Source media/patch preservation is recorded. Neither protected project was modified.

## Next decision gate

Before another behavior candidate, identify the actual loaded Station module/resource token and its address, using the original bootstrap's resolved call/import relationship and bounded private runtime bytes where necessary. Completion requires a supported address/token observation and proof that a proposed replacement applies. A fixed published address alone is insufficient. No listener-only repeat or speculative authentication response follows from R01.

The intended progression remains visible account login → observed account/server-selection flow → client-driven **standard character creation from an empty list** → character selection/world entry → one player, movement and save/load. Exact transition ordering remains subject to client evidence. No pre-provisioned standard character or future unusual race/class/ruleset experiment substitutes for creation coverage. E01 remains PARTIAL, Evidence Acquisition OPEN, and broad Protocol Implementation CLOSED.
