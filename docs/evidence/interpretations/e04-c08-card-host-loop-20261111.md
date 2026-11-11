# E04-C08 — card check completes; host-file reads fail

Session `E04-C08-20261111T111030107Z`, November 11 local time. The operator reported the memory-card message as the last screen. This review inspected the saved execution trace, account result, artifact inventories and restoration records. No additional guest run was launched.

## Observed transition

**CONFIRMED — client/protocol**, scoped to the instrumented Frontiers lab configuration. The tracer resolved its required exports from the live module tables, including card status at `0x003E72C8`, session comparison at `0x002AB500` and card read at `0x003E8098`. The bootstrap's post-Station client call was observed at emulator-relative 88.8622 seconds.

| Time (emulator-relative seconds) | Observed operation |
| --- | --- |
| 97.2157 | Card status returned `0` |
| 97.2334 | `session.id` read returned eight bytes; session comparison returned `1` |
| 97.2334–97.2335 | Owner messages `0x1102` and `0x1106` were called and returned; the latter carried result `1` |
| 97.4001 | `game.opt` read returned 1,024 bytes |
| 97.4330 | `althosts.txt` read returned `0xFFFFFFFE` (signed −2) |
| 97.4333 | `eqahosts.txt` read returned signed −2 |
| 97.4334 | The client opened the card-check window again |
| 98.7532–98.7863 | Session comparison and callbacks completed again, both host reads failed again, and the check window reopened |

This establishes a repeating completed card check followed by failed host-file reads. The trace does not support diagnosing the observed cycle as a card-status call stuck waiting. Earlier card reads for word resources also returned −2, but execution subsequently reached options and host loading. Missing card vocabulary files alone do not establish a required download.

**CONFIRMED — reference.** The pinned public [host-loading routine](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/client/src/viwndinitfrommc.cpp) tries `althosts.txt` first and `eqahosts.txt` only after a negative read result. Failure of both returns −1 and causes another card-check window. It parses whitespace-separated `host:port` tokens; absent an explicit port, the reference default is 10070. Alternate-file precedence is based on read success, with no demonstrated reachability fallback.

**INFERRED.** Missing host configuration explains this observed loop and is the next focused correction. Successful loading of an independently authored lab host entry, the next network operation and server-selection rendering remain **UNKNOWN** until observed. Port 10070 is a reference-derived candidate, not a confirmed Nighthaven wire requirement.

## Coverage and integrity

The trace contains 522 prefixed lines, including activation/resolution lines and the bounded operation log. It reaches its 512-event operation budget; later execution is unobserved by this logger. There is no pending-return-capacity warning. The decisive first cycle and repeated cycles occur before exhaustion. Absence of later checkpoints cannot establish a later failure or success.

The account probe received 148 bytes, verified the saved account and recorded 168 application bytes sent. This run adds no account creation or server-selection success. All 124 references across input, run and session inventories passed size and SHA-256 validation. The runner records normal operator close, guest stopped, fail-closed INI, DNS restoration, listeners stopped, temporary listener firewall removal and physical-adapter restoration. It records source card, ISO and patch preservation. The original-settings check reports non-log settings unchanged.

The stored screenshot is byte-identical to the prior C07 memory-card screenshot; it supplies no independent timestamped screen confirmation for C08. The C08 last-screen statement is the operator's report. Raw evidence remains restricted outside Git.

Emulator log SHA-256: `22d0b774debfe12508866a7e565ef84f5d41de27f174d906dd77973c61b3ed0b`. Session result SHA-256: `8d8fb1bea9e57305e03b487f61014c48273add9db1af38057e0371f190f29da2`.

## Next focused preparation

**NIGHTHAVEN DECISION.** Prepare original lab-only `althosts.txt` and `eqahosts.txt`, each containing the single ASCII line `198.18.0.1:10070` with an LF terminator. Both are identical so alternate-file precedence cannot select an external host. This specifies a candidate shard-list endpoint, distinct from the account endpoint on TCP/9735. It creates no listener or server functionality.

Keep these candidates outside the frozen C08 bundle. Verify a client-compatible delivery path into a fresh disposable working card before a live test; host-side text files alone are not visible to the guest. Preserve source cards and existing baseline responses. The acceptance evidence is a positive host-file read, successful host-list loading and the subsequent execution/network transition. A game-service response and server-selection display are separate unverified milestones.

The prepared files reside in the private lab's `E04-C09-host-config` directory. Each is 17 bytes with SHA-256 `81472e1923791a1212b2c0b57684189d0e72faad75f3fe5e8aaec7c847df6666`. Neither has been installed on a card or added to an updater response.
