# E01-D01 — diagnostic channel verified; post-update target not reached

Reviewed November 1, 2026 (America/Chicago), from `main` at `c7b5fb5`. [Manifest](../manifests/eqoa-frontiers-us-e01-d01-20261101-001.json) registers `E01-D01-20261101T135950501Z`. **BLOCKED for the requested post-update investigation.** Preserve the harness outcome `INVALID_OR_BLOCKED`; useful diagnostic evidence does not make the intended experiment successful. No automatic retry occurred.

The operator requested one focused run to identify the first failed module/resource operation after updating. The prepared card, updater and receive-only account probe were retained. D01 used the original guarded DNAS/resolver candidate plus independently encoded diagnostic call substitutions. It imported no external loader, replacement UI, proprietary resources, historical implementation code or account handler.

## Instrumentation and its limits

**CONFIRMED — reference**, original operator-media static evidence: 33 bootstrap loader `printf` calls were redirected to the original `scePrintf` export. The original call delay slots, return addresses, argument preparation and success/error branches remain unchanged. Conservative local liveness checks find every selected diagnostic return value discarded. Seventy guards check the original call words and callee fingerprint before applying the diagnostic group. These are diagnostic instruction changes, not a new loader or an assumed successful operation.

The original SDK output path reaches the DECI2 kputs operation. The inspected [PCSX2 syscall implementation](https://github.com/PCSX2/pcsx2/blob/fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3/pcsx2/R5900OpcodeImpl.cpp) routes that operation to the EE console. This avoids relying on developer-only trace channels. Eight diagnostic patch checks, eight in-memory reader checks and 110 harness regressions pass; they do not establish behavior-neutral instrumentation.

The localhost-only observer checked process ownership and client CRC, read a fixed 204-byte set of module-state/call words and emulator run/pause status, and retained those bounded bytes privately. It sent no memory writes and captured no CPU-register/PC snapshot. An enabled private debugger recipe targeted the original Station entry call and known loader failure loops. Import/enabled metadata alone does not prove breakpoint execution.

## Observed result

The console records disc fallback and successful image processing/module initialization for **SUPPORT, MCERR and SETUP**. The observer verifies all **33 diagnostic call substitutions** in guest memory across 2,603 samples/16 recorded states. Thus the diagnostic channel actually worked, unlike R01's unverified resource change.

No STATION or CLIENT load is recorded. Their observed module slots remain zero and their bootstrap calls remain unresolved link placeholders. The SETUP call is resolved. **INFERRED:** this run remained in the earlier setup/DNAS phase; it did not reach the intended Station/login handoff. These observations do not explain the separate earlier post-update loading failures.

**CONFIRMED — client/protocol**, this modified Frontiers US / PCSX2 2.8.2.0 session only: the 32-frame TAP capture contains eight TCP SYN attempts from `198.18.0.2` to `198.18.0.1:443`, with no reply/application payload. There is no captured TCP7000 updater or TCP9735 account exchange. Both prepared listeners report NO_CLIENT/zero received bytes. Port 443 alone establishes no TLS or application contract.

The operator reports **DNAS Connecting**, then manually pausing, resuming and closing the debugger/lab. That pause is not a confirmed automatic checkpoint hit. No screenshot or exact waiting PC was collected. The reason DNAS progression regressed is **UNKNOWN**; do not infer that adding a port443 service would fix it.

## Test-design correction before any further run

Static inspection places one redirected diagnostic call at `00101F60`, before UTIL allocation at `00101F6C`. **INFERRED risk:** replacing early stdio diagnostics may change allocation or timing while the existing compatibility patch assumes fixed UTIL addresses. This is a plausible instrumentation effect, not an experimentally proved cause. D01 sampled its new diagnostic words but did not sample the original DNAS replacement words, so their effective application in this run remains UNKNOWN.

Do not repeat D01 unchanged. A corrected design must preserve pre-UTIL startup, verify the working DNAS replacements at their actual loaded locations, and activate diagnostics only after those prerequisites hold. It must verify readable loader output before the operator spends another network transition. Further execution requires a separately scoped run; no new candidate or live retry follows from this review.

## Preservation and recovery

All **85 original artifact references** match. Frozen tools, raw diagnostics, card output and captures remain in restricted EFS evidence storage outside Git. All 1,298 reviewed physical-adapter samples during the guest interval show administrative isolation without observer errors; sampled observations are not universal coverage proof. Source ISO/cards/original patches were preserved, and neither protected project was modified.

Independent elevated verification at `2026-11-01T14:16:42Z` confirms normal guest closure, exact original profile restoration, networking/cheats/PINE disabled, stopped capture, absence of temporary 7000/9735/28121 listeners, firewall cleanup, and DNS/physical-adapter restoration. No operator setup or repeat run is requested by this result.

Architecture Gate #2 PASS carried forward; Evidence Acquisition OPEN; E01 PARTIAL; broad Protocol Implementation CLOSED. Account login, server selection, standard client-driven character creation and first playable world entry remain downstream goals.
