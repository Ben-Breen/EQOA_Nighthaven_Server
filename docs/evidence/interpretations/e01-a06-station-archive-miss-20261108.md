# E01-A06 — Station archive lookup misses

Reviewed November 8, 2026 (America/Chicago). Session `E01-A06-20261108T192008723Z`, Frontiers US SLUS-20744 / EEEE1FCC in the isolated PCSX2 lab. The v1 patch, updater and receive-only account probe remained fixed. The private emulator candidate checked for the exact `/station.pak` token at a reference-derived data address and could remove its leading slash in guest memory only if the live guard matched. The [reference disc-open helper](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/src/vifile.cpp#L82-L107) supplies a separator, uppercases the path and translates forward slashes.

Two network-disabled synthetic controls demonstrated the exact-match rewrite and preservation of a mismatch. In Frontiers the live guard returned `exact=0 basename_applied=0`, so the proposed correction **did not apply**. This does not test whether removing the slash at the actual file-open argument would help.

**CONFIRMED — client/protocol**, scoped to this lab run. Station Init returned zero. The login archive lookup at `0x002CB50C` returned null. The subsequent loose parser at `0x002CB56C` also returned null for the login-page request. No archive-registration checkpoint was recorded. The operator reported a black screen. TAP captured 47 frames, including 30 TCP frames on the updater path. The account probe saw `NO_CLIENT`.

**UNKNOWN.** The actual archive filename and disc-open return were not captured. A null lookup does not establish which archive was tried or why the original disc entry was unavailable to the renderer.

**NIGHTHAVEN DECISION.** Retire the fixed string-address guard. Use the actual renderer call instruction, its verified delay-slot argument setup and the runtime filename. Log the matching open return and allow any basename repair only on the exact archive token under the live guards. Check archive registration, the login lookup and the parser in the same experiment. NH-E01 remains PARTIAL.

The guest closed normally, the runner reported source-card/ISO/patch preservation and complete restoration, and the trace INI matched its fail-closed hash afterward. The raw evidence remains restricted outside Git. Execution log SHA-256 `8f235884edd0a80fbba503785061d58b95086f95404426ddd50f31dd04103b8c`. First pcapng SHA-256 `36c707b1af97f8d208a777fabfc3ee711659268d4167d76f09c849b3c15ddaaf`. Session manifest SHA-256 `e55027b7fdf41da0b41b83711c527d121d8892300935383f9f310d12a3f6b9f3`.
