# E04-C08 — automatic post-news card-operation trace

## Question

Which card-status call, session comparison or completion callback is unresolved after the [C07 news transition](../interpretations/e04-c07-post-news-card-review-20261110.md)? If those complete, which file read follows and what does it return?

## Prepared configuration

Use the saved C06 lab account, C07 protocol behavior and original news candidate with the isolated TAP and capture harness. The local C08 executable adds passive host execution logging. Its card diagnostics make no guest-memory writes. The established Station basename correction remains part of the baseline.

After the bootstrap's client call, the tracer checks the module registry and SNR export tables and resolves card functions by their exported names. It logs relevant calls, their matching caller returns, permitted ASCII filenames and the memory-card completion message. It does not print file contents, credential values or session IDs. Direct and indirect calls and their delay-slot argument setup are handled by the local logger. The output has a 512-event budget and a 32-entry pending-return budget. Missing symbol resolution or a budget failure must be retained as a qualification on the result.

The intended checkpoints are card status, session comparison, card-file reads, the underlying card-info/sync calls when their exports resolve, and the MCERR owner's completion callback. The trace must show which runtime exports resolved before its results are interpreted. A reference address or synthetic success alone cannot establish a live checkpoint hit.

## Offline verification

- The build completed successfully. Binary SHA-256 `6b08ffed36d4e827e9b40fdaf43c39dd76f2f38a9e7382997434c227ba6b0d95`.
- Network-disabled synthetic control `E04-CardControl-20261111T055733960Z` verified card-status return zero, session result one, a named file read returning −2, and the owner completion callback and its return. An invalid-registry control produced no card-call evidence. The original INI was restored.
- Network-disabled archive control `E01-ArchiveControl-20261111T055852991Z` verified the original match/mismatch basename guards in the new binary.
- The pinned package, 119 harness checks, database-verifier and repeated-login framing tests, and nine-request HTTP/news test passed.
- The local MySQL connection and schema passed a read-only check. PCSX2 was closed and the fail-closed INI matched SHA-256 `926d6f3a67a9a6cf08ceb855bf23b0ae4b68e0f871326dd93096ac4fbb6651ea` after the controls.

These checks established diagnostic readiness. The [reviewed C08 result](../interpretations/e04-c08-card-host-loop-20261111.md) records completed card/session checks and callbacks followed by repeated failures to read both host files. The operation trace exhausted its budget later in the run; subsequent execution remains unobserved.

## Operator procedure

Run the private `Start-E04-C08.ps1 -Mode Run` launcher from elevated PowerShell 7. Wait for READY, accept the EULA if prompted and select Play → EQOA 2. Log in with the saved C06 account. At news, select Continue. Take F8 at the memory-card dialog or the next stable screen, allow the trace to record the wait, then close PCSX2 normally. The trace requires no debugger pause. Listener timing remains controlled by operator close or stop markers.

## Interpretation and cleanup

Check the actual resolved function names and targets. Correlate calls and returns, then the session result and completion message. If startup advances, identify the next recorded filename and result. A missing return is evidence of an unresolved call only if checkpoint coverage and logger budgets remain adequate.

Inspect the captured traffic and screenshot alongside that trace. Verify card, source-media and original patch preservation and all restoration records before scheduling another run. Keep raw logs, captures, screenshots and working-card outputs in restricted storage. Server selection and character creation remain open until observed.
