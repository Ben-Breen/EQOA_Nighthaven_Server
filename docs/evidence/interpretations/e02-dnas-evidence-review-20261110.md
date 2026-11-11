# E02 — DNAS evidence review

Reviewed November 10, 2026. Scope is Frontiers US SLUS-20744 / EEEE1FCC in the isolated PCSX2 lab. This review uses the existing result records and guarded candidate audit.

| Run | Observed order | Comparison limits |
| --- | --- | --- |
| [E00 N01](e00-n01-baseline-closeout-20261108.md) | Three unpatched cold starts produced matching DNS observations and ended at DNAS Error (-611). The third capture shows no guest IPv4 traffic outside DNS. | The REFUSED replies and error co-occur. The cause of -611 remains UNKNOWN. |
| [Initial E01 PNACH run](eqoa-frontiers-us-e01-20261031-001.md) | DNAS Status: Done → update connection to lab TCP/7000 → update error. | DNAS return/status changes and shared-resolver redirection were enabled together. The run used the N02 source card and had no working updater response. |
| [A06](e01-a06-station-archive-miss-20261108.md) and [A07](e01-a07-login-screen-20261108-001.md) | With the same v1 PNACH and prepared card, A06 reached Station Init but missed the login archive. A07 reached the login form and established TCP/9735 before input. The [second A07 run](e01-a07-login-submission-20261108-002.md) repeated archive registration and produced a 148-byte TCP segment after the account probe timed out. | The A07 renderer call-site change acts after the updater. The account bytes do not isolate the earlier DNAS gate. |

**CONFIRMED — reference**, scoped to the audited candidate. The v1 PNACH groups the DNAS return/status changes separately from the shared resolver redirect to `198.18.0.1`. The private audit records 23 DNAS writes behind five guards and five resolver writes behind four guards. The A07 basename change is in the trace executable, with a separate runtime guard.

**INFERRED.** The combined v1 candidate allowed progression beyond the failure seen in the unpatched baseline. **UNKNOWN:** whether the resolver redirect alone is sufficient, which DNAS writes are required, and whether the original DNAS path could progress with a valid service response. The reviewed observations do not establish a DNAS wire exchange or cover all emulator-internal traffic.

## Proposed first E02 live differential

Use A07 run 1 as the patched comparison. Cold-start a disposable A07 configuration with the DNAS return/status group removed and the reviewed resolver group retained. Keep the executable and basename guard, ISO/BIOS, working copy of the same source card, TAP containment, DNS policy, and pinned updater responses fixed. Before launch, statically verify that the resolver words and guard skip counts match v1 and that the DNAS sites retain the original words. Record the candidate hash separately from v1.

Start TAP capture before Play. Record DNAS screen progression or the stable error, DNS outcomes, attempted connections including any DNAS-associated flow, and the first TCP/7000 attempt if present. Stop at a stable DNAS error or the login form before credential input. Verify restoration using the saved harness records.

- If the guest fails at DNAS before the updater, the DNAS group contributes to progression in this contained configuration. This would leave individual writes and service-side behavior open.
- If the guest reaches the updater, the DNAS group was unnecessary for that transition under the tested resolver and containment settings. Compare endpoint and screen evidence before drawing a broader conclusion.
- If the retained resolver guard fails or another input differs, record the result as inconclusive for the DNAS comparison.

## Resolver-only retry result

The first D01 attempt was inconclusive. The observer misindexed its expected instruction table and the harness closed PCSX2 when network activity started before READY. The observer lookup was corrected before the retry.

**CONFIRMED — client/protocol**, scoped to the isolated retry `E02-D01-20261111T000642339Z` (November 10 local time). Runtime readiness passed 28 checks for the original DNAS instruction patterns and patched resolver words. The operator reported that the client looped at DNAS. TAP recorded ten SYNs with zero payload to `198.18.0.1:443`, with no decoded replies or TCP/7000 or TCP/9735 frames. The updater listener reported `NO_CLIENT`. First capture SHA-256 `ddc7dc236f5e08cf780f21b2e692fe889437e93b22db758119d285f31195ef89`. The runner finished after normal close and reported that all restoration checks passed.

**INFERRED.** The resolver redirect alone was insufficient with the lab's existing services. The full DNAS group allowed progression in the comparison runs. **UNKNOWN:** which individual writes matter, the TCP/443 application protocol, and whether providing the expected response would let the original DNAS path progress. NH-E01 remains PARTIAL. Raw evidence stays in restricted storage.

## D02 — receive-only TCP/443 result

Session `E02-D02-20261111T001643822Z` (November 10 local time) reused the resolver-only candidate and added a TAP-bound receive-only TCP/443 probe. The operator reported DNAS Error −610. The packet capture records one completed TCP handshake, one 102-byte client payload and zero host application bytes. The probe independently recorded 102 bytes, then closed after its idle-after-data limit. No decoded TCP/7000 or TCP/9735 frames were present. The runner finished with all restoration checks passed.

**CONFIRMED — client/protocol**, scoped to the captured first message. The record matches the SSLv2-compatible ClientHello layout. It declares a 100-byte record body, message type 1, version `3.1` (TLS 1.0), and section lengths of 75, 0 and 16 bytes. The nine-byte message header and those sections account for all 100 bytes. This establishes the greeting format and advertised version. The server handshake, certificate requirements, DNAS application request and meaning of −610 remain **UNKNOWN**. [RFC 2246, Appendix E.1](https://www.rfc-editor.org/rfc/rfc2246#appendix-E.1)

First pcapng SHA-256 `2e7b10051e17d240993f1472138d3ba7c357ca592e00c368996190bb81def81f`. Probe payload SHA-256 `7ee7e2ead463c221a6e3e5a835b31692246890fd9dbab71b08b0e8cd34009552`. Raw bytes remain in restricted storage.
