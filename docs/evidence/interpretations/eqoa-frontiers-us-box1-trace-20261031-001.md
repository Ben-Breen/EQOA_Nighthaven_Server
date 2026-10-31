# Box1 operator-driven trace — scoped result

Reviewed 2026-10-31. **PARTIAL: login operator-reported; loader tracing unresolved.** The user authorized launch/capture, then explicitly took control and removed the time limit. Session `E01-TRACE-OP-20261031T202503463Z` ran from capture-ready 20:25:05Z / guest-start 20:25:29Z until normal operator close; capture finished 20:27:50Z. No fixed session timer was enforced. The laptop stayed online; original media and the isolated Nighthaven profile were preserved.

## Findings

- **CONFIRMED — client/protocol**, scoped to this patched PCSX2/external-service environment: the filtered capture contains 27 TCP frames across three TCP/7000 exchanges. The first 104-byte request matches earlier runs. The 463-byte gzip manifest decompresses to the same XML as the prior external reference, despite different compressed bytes. Two Changes exchanges return the same 119-byte body hash as before. Response content remains private; no external content is copied into Nighthaven.
- **CONFIRMED — reference**, emulator diagnostic log only: at 124.2656 elapsed seconds, PCSX2 records creation of a TCP connection to port 9735. The capture filter covered only the known external address/TCP/7000, so **no 9735 payload is captured**. [Historical source](../../protocol.md) also uses 9735 for its account listener. An account-service role is **INFERRED**, not a demonstrated exchange/schema or explanation of U02's black screen. The log line does not establish the remote IP or successful account authentication.
- The operator confirms **account login screen reached**. No screenshot was available for independent visual confirmation. Do not convert this report into an observed successful login/authentication exchange.
- **UNKNOWN:** actual activation/hits of the five debugger points, post-update filename/source, helper return values and loading/decryption/transition cause. The persisted recipe still has all five points disabled; that alone does not prove they were never enabled in memory. No checkpoint snapshots/records were supplied. Enhanced logs record startup/module activity but do not establish the requested post-update loader sequence.

The earlier attempt `E01-TRACE-20261031T202044491Z` was stopped after UI screenshot timeouts and unavailable input geometry. It obtained no verified checkpoints or updater traffic and is retained separately. The later user-directed run is not a repetition proving full loader coverage.

## Cleanup and provenance

Capture/filter removal succeeded. The runner initially deferred INI restoration while a process still appeared open; after confirming every emulator closed, the verified original INI was restored at 20:28:30Z. All ten original source fingerprints match, including Box1 cards/patch/BIOS/configuration and the Nighthaven profile. The deferral is retained in the original report; a separate recovery record documents completion rather than rewriting the failure. The exact used runner is frozen privately. A future helper revision releases its exited-process handle before testing profile-restoration readiness; no guest rerun was performed for that change.

Logs, private working-media outputs, recipe, used runner and reassembled streams are frozen in the restricted EFS session directory outside Git. The staging inventory describes its preparation-time working copies; later runtime writes are separate outputs, not silently substituted baseline evidence. No passwords, packet bytes, screenshots, assets, source-card bytes or external implementation code are published.

| Private artifact | SHA-256 |
|---|---|
|Final inventory|`fcc53dc5a5b3c6d78b551dc3530c559da0f3762d014816e29665c69c6306af0a`|
|Frozen emulator log|`f74fee8b8ee9eab38e0cc10e6dc73cc830e044fc2885926742b92b719ea097e9`|
|Deferred-restoration verification|`5811c8987dcd3c00f6414c5bd510147681dc8c8c70b9cc6bcaac5691692506ba`|
|Review|`15c6aa6da5637d64c90d03cae610c177f9352fb71ae6a7294c66d3bef8b70004`|
|Filtered capture|`03a02beff6df3046a7a6ff7e5297733bd0173c09d89c3fbf08ed746cc741fe2f`|

## Next evidence gate

Do not repeat an updater-only capture expecting filename evidence. First validate manually observable debugger import/hits or continue offline loader mapping. Any future 9735 capture needs its own explicit scope/approval, sensitive-data handling and a stop before credentials; port semantics and payloads must not be invented from a listener in historical source. A lab transition experiment remains separate and unperformed. Architecture Gate #2 PASS carried forward; Evidence Acquisition OPEN; E00/E01 PARTIAL; broad Protocol Implementation CLOSED.
