# Account-endpoint selection — offline evidence and DNAS preservation

Reviewed November 1, 2026, from `main` at `c9398a3`. **Static investigation complete for this scope; original-client runtime binding and account-login goal remain unresolved.** No guest, listener, capture or network-configuration operation occurred. [Evidence manifest](../manifests/eqoa-frontiers-us-account-endpoint-static-20261101-001.json).

## What selects the account endpoint

**CONFIRMED — reference:** the public matching-decomp revision `e803a6abd9b038c758603dc0f236561906d5530b` describes this chain:

| Step | Inspected reference behavior | Evidence |
|---|---|---|
| Select host source | `LoadServers` prefers alternate hosts, then live hosts, then a compiled numeric fallback on9735 when neither file exists. | [LoadServers](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/viwndgenericrenderer.cpp#L330) |
| Parse list | `AddServers` parses host:port lines and adds candidates to the account API. | [AddServers](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/viwndgenericrenderer.cpp#L266) |
| Choose and connect | The API selects an entry; `VITCPConnection` sets its host and port and opens its socket. | [API](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/vistationapi.cpp#L727), [connection](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/vitcpconnection.cpp#L82) |
| Resolve and open | `TCPSocket::Open` calls `sceInetName2Address` for every non-null host, including numeric text, then uses the chosen port with `sceInetCreate`/`sceInetOpen`. | [socket](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/tcpsocket.cpp#L66) |

The central routines appear in that revision's [MATCHED list](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/MATCHED.txt). This is the source project's matching claim, **not an independent byte comparison against the operator's encrypted Station image**, and not captured client/protocol confirmation. No implementation code was imported.

**CONFIRMED — reference, original operator media inspected in place:** the 82,094-byte original `STATION.PAK` parses as25 bounded records. Its live-host entry has numeric IPv4:port syntax with port9735; there is no alternate-host entry. No resource contents or original endpoint values were copied into Nighthaven. The bootstrap exports `sceInetName2Address` at `00124AE8`; execution reaches the replacement at `00124B18` without a preceding numeric/hostname branch. Original UTIL records name that resolver, create and open functions as unresolved imports, rather than independent implementations.

**INFERRED:** if Station binds to the inspected bootstrap export, the existing resolver replacement should redirect all three host-selection paths to the lab address while preserving9735. **Correction to the earlier lead:** a numeric host does not by itself bypass this function or justify another endpoint patch. Actual Station import binding, execution and final destination remain **UNKNOWN** in the lab. This is the next runtime question.

## Live, alternate and fallback coverage

The selection is based on file presence; it is not demonstrated health-based failover. An alternate file can suppress the live file even if unusable. The inspected `ChooseServer` returns a zeroed server when its list is empty. Therefore an empty/malformed selected file must not be assumed to trigger the compiled fallback automatically.

| Source | Current original-pack evidence | Required later acceptance evidence |
|---|---|---|
| Alternate hosts | Absent | When selected in a separately scoped case, the effective socket destination is Nighthaven-controlled; empty/malformed behavior is observed. |
| Live hosts | Present,9735 | Selected host reaches the intended resolver and lab TCP9735. |
| Compiled fallback | Present in reference code | When neither host file exists, the fallback is intercepted and cannot contact a defunct external service. |

Before the first login baseline, prove the **active** path and effective destination. Broader selection/failure cases remain later coverage; this review requests no extra test runs. Legacy text retained in an original resource or HTTP Host field is distinct from an actual legacy socket destination. Nighthaven must control effective endpoints. Do not edit original media merely to remove inactive strings, or create a replacement UI pack to carry one configuration value.

## Connection readiness and the first screen

**CONFIRMED — reference:** the matched original connection routines use socket-open state. `VIStationAPI::Connect` invokes its connected callback after successful open, without waiting for received application bytes. The existing receive-only lab9735 probe could therefore satisfy this reference transport criterion **if the client reaches it**. It has received no lab connection so far; a guessed reply cannot fix an unexecuted connection path.

The native Rust reference deliberately replaces the hosts-file selection with its own saved server and uses first received data for asynchronous readiness. That adaptation is not original PS2 behavior: [native override](https://github.com/DabDavis/eqoa-rust-client-vanilla/blob/42e41f8a6f01f688d9468115a8c1d0945df6b539/crates/eqoa/src/pregame/station/renderer.rs#L189), [native API](https://github.com/DabDavis/eqoa-rust-client-vanilla/blob/42e41f8a6f01f688d9468115a8c1d0945df6b539/crates/eqoa/src/pregame/station/api.rs#L139). Its session-key greeting remains a useful later protocol lead, not a confirmed prerequisite for displaying the original login page.

The decompiled UI loading/drawing routines suggest connection processing can precede page drawing, but those routines are not in the inspected MATCHED list. Exact first-screen timing remains UNKNOWN. No account server or port443 response is implemented by this finding.

## Locate modules rather than guessing addresses

**CONFIRMED — reference, original bootstrap static evidence:** `SN_LOADED_RELMODS` is exported at `0016DA10`. Inspected writer/removal/init routines establish a bounded registry:

- Header: slot high-water count, then `count XOR 0x31415926`; maximum1024 slots.
- Entries:12 bytes each, starting at header+8: ID, module pointer, and `ID XOR pointer XOR 0x31415926`.
- Zero pointers mark inactive slots. Removal does not reduce the high-water count.

A future read-only snapshot can validate this structure and then validate active SNR headers/fingerprints to identify actual module bases. A slot number or pointer alone does not establish module identity. Runtime registry contents have **not** been collected. A local offline decoder passed seven synthetic integrity/bounds tests; no memory-access client was added.

The reference [Station symbol map](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/symbols.txt) declares analysis base `002B6A80`. Its unnamed `003635A0` data symbol is offset `000ACB20`; `station_main` is base+`100`. R01 did not establish this absolute address in the lab. Deriving a candidate address from a verified runtime base is preferable; the exact symbol-to-filename mapping still needs bounded inspection before any write.

## Preserve DNAS before enabling diagnostics

D01's early logging could alter the original stdio1024-byte allocation before UTIL loading; this remains an INFERRED cause, not a proved diagnosis. The flag at `001478E4` follows an RPC-binding loop inside `VIDisplayLoadingScreen`; it is not itself proof of module placement or successful authentication.

**NIGHTHAVEN DECISION, offline preparation only:** D02 preserves the complete v1 PNACH prefix byte-for-byte and gates diagnostic writes on all nine original guards, all28 expected DNAS/resolver replacement words, and the original diagnostic call/callee fingerprints. Its135 guards/33 writes fit the extended-code skip bound. Eight offline tests pass, including every mismatched prerequisite, pre-UTIL inactivity, exact prefix preservation and skip boundaries. Previous candidates remain unchanged. D02 is **NOT RUN**, has no new launcher, and is not installed in an active profile. This does not prove behavior-neutral tracing.

**Measurable next readiness gate, only in a separately authorized future contained session:** retain the original startup; record validated module-registry/SNR evidence for actual UTIL placement and all28 expected replacement words before Play. The candidate itself waits for matching words/fingerprints, but does not wait for a host readiness report; a future launcher must account for that distinction. If placement/words do not match, leave diagnostics disabled and stop before the DNAS/network transition. Once ready, trace the actual Station load, resolver binding/return and TCP9735 attempt. Later module bases must still be derived dynamically.

Box1 online success remains a positive comparison, not a single-variable control for the offline lab: patch groups, resources/card state, network backend, BIOS/profile and service behavior differ. Earlier lab DNAS Done/updater exchanges already show that containment alone does not prevent those stages. Preserve those successes; do not add speculative HTTPS or account replies to mask a changed startup.

Architecture Gate #2 PASS carried forward; Evidence Acquisition OPEN; E01 PARTIAL; broad Protocol Implementation CLOSED. The next product milestone remains the original Login/Create Account screen, followed by observed server selection, full standard character creation, world entry and movement/save-load.
