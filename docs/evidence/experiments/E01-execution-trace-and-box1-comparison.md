# E01 execution trace and Box1 comparison

Status: collected and reviewed on November 8. [Isolated trace result](../interpretations/e01-a05-login-parser-20261108.md). [Online Box1 comparison](../interpretations/e01-box1-server-selection-20261108.md). The procedure below records the test boundaries.

## 1. Isolated Station execution trace

Keep the verified v1 DNAS/resolver patch, prepared-card clone, updater and receive-only account probe fixed. Use a separate, pinned PCSX2 2.8.2 lab build. The host-side EE trace should emit a bounded record when the Station entry or a verified return executes, with the EE PC, low 32 bits of `v0`, run ID and timestamp or EE cycle. Guard every Station checkpoint with the current module identity, placement and corresponding live call instruction. Record trace activation at a known earlier checkpoint. With the recompiler, emit the callback into executed code after synchronizing guest registers. A compile-time observation cannot establish execution. [PCSX2 interpreter dispatch](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/Interpreter.cpp), [EE recompiler](https://github.com/PCSX2/pcsx2/blob/v2.8.2/pcsx2/x86/ix86-32/iR5900.cpp).

| Trace event | Evidence to retain |
| --- | --- |
| Station entry | Actual execution at the validated entry. This distinguishes a loaded module from a called module. |
| Init return | Signed low 32 bits of `v0` at the verified caller return. A negative result focuses the next analysis on required CSF loading. |
| Login-page parse, if Init succeeds | Match the actual login-page request using a bounded filename check. Record whether the parser returned a page pointer, and correlate subsequent activity with the TAP trace. |

Before running the client, prove the logger records known guest return values and skips nonmatching checkpoints. Record the build and trace hashes. Keep a positive trace-activation event so a missing return can be distinguished from an inactive logger. Capture on TAP before boot and stop at account login or the stable blocker, before credentials. No further guest instruction changes, debugger pauses or auth replies are part of this test.

## 2. Box1 through server selection

Use the operator's empty throwaway account on the existing online Box1 setup. Freeze or fingerprint the effective Box1 configuration and use a disposable working card where applicable. The operator enters credentials directly. Start a process-attributed, metadata-only network trace before boot. Do not limit the trace to TCP/7000, since the purpose is to observe subsequent connections. Record timestamps, direction, transport, port, connection events and byte counts with host endpoints sanitized for publication. Avoid payload collection in the credential phase. The existing updater-only packet capture is a separate artifact.

Mark the time of login submission, the first visible server selection screen and any resulting network transition. Stop on the server selection screen before selecting a world or creating a character. Preserve raw metadata privately and publish only reviewed observations and hashes. Box1 is an online comparison environment. The run can establish sequence and traffic observed in that environment. It cannot establish which service behavior the unpatched client universally requires.
