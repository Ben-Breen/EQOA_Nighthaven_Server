# E01-A03 — Station initialization checkpoints

Reviewed November 8, 2026 (America/Chicago). Session `E01-A03-20261108T170634642Z`, Frontiers US SLUS-20744 / EEEE1FCC in the isolated PCSX2 2.8.2.0 TAP lab. This run preserved the [A01 patch, updater and probes](e01-a01-station-binding-20261108.md). The debugger started with a single EE Execute breakpoint configured at bootstrap `0x0010169C`. The passive observer added no guest writes.

## Observed in the run

- **CONFIRMED — client/protocol**, scoped to this run. TAP capture and both probes were ready before guest launch. The observer verified UTIL and all 28 patch words before the first logged DHCP send. Station was present at base `0x002B6A80` with linked entry `0x002B6B80`, reproducing A01. The worksheet derives the return PCs below from unique JAL instructions in the loaded code and their delay slots.
- **CONFIRMED — client/protocol**, scoped to the TAP boundary. There were 48 frames, including 30 TCP frames, all on the TCP/7000 updater path. Three updater connections carried 220 client bytes and 543 server bytes. There was no captured TCP/9735 or TCP/443 attempt. The receive-only account probe reported `NO_CLIENT`.
- **Operator observation.** The operator paused twice manually. No EE PC, return register or debugger screenshot was recorded, and no game screenshot was retained. The saved breakpoint recipe is configuration evidence. It does not establish a breakpoint hit.
- **UNKNOWN.** The Station Init return value, actual script or archive open result, login page parse result, host selection and account login remain unverified. A loaded callsite establishes a breakpoint address for this profile and module placement. It does not establish that the call ran.

| Verified loaded-code return point | EE PC in A03 | Value to capture while stopped |
| --- | --- | --- |
| Caller after `VIStation::Init` | `0x002B6C98` | Low 32 bits of `v0` (`r2`). The matched caller treats a signed negative result as failure. |
| Login page loader after archive `Find` | `0x002CB50C` | `v0`. A nonzero pointer is a lookup hit. |
| Login page loader after archive-memory parser | `0x002CB548` | `v0`. A nonzero pointer indicates a parsed page. |
| Login page loader after loose-file parser | `0x002CB56C` | `v0`. A nonzero pointer indicates a parsed page. |

## Resource evidence and next checkpoint

**CONFIRMED — reference.** The matching-decomp reference shows the Loading screen before four required CSF parses. The US base files are `ArialUI.csf`, `ui.csf`, `statui.csf` and `pregame.csf` under `data2`. The caller exits on a negative Init result. The matched page loader prefers a matching archive entry and otherwise tries the loose path. The earlier renderer `Load` routine is a reconstruction and remains a hypothesis for the archive selection sequence. [Init and CSF calls](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/vistation.cpp#L66-L83), [Init caller](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/main.cpp#L37-L45), [page loader](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/viwndgenericrenderer.cpp#L567-L585).

**CONFIRMED — reference, original media index.** Read-only directory inspection found all four base CSFs on the disc and the exact `data/ui/login.xml` record in the original `STATION.PAK`. The loose `/DATA/LOGIN.XML` is at a distinct path. The disc inventory does not establish which resource a live client selects or whether it opens and parses successfully.

**NIGHTHAVEN DECISION.** Prepare an automatic EE Execute stop at the verified Init return and capture the paused EE PC with `v0` in the same evidence record. Revalidate Station placement and the caller's JAL before treating that address as applicable. Use a negative Init result to focus the next trace on the first failed CSF. If Init passes, correlate the actual login page request with its parser return and then check host selection and TAP traffic. Keep the updater and DNAS patch fixed. Game server selection after account login remains a later gate.

## Integrity and rollback

The runner completed normal closure and verified the source card, ISO and patches. PCSX2 is closed, the fail-closed INI is restored, DNS is stopped, and ports 7000, 9735 and 28121 have no remaining listeners. Firewall and physical adapter restoration were recorded. PktMon reported no events lost. Review checked 116 references with zero mismatches and verified restricted EFS storage for all 74 session files. Raw records remain outside Git.

| Restricted artifact | SHA-256 |
| --- | --- |
| Session result | `ee994d8cab70201d7f685fcc9bc8fe3bdeaea756a74edfb524db63d776a335bc` |
| Station worksheet | `1e45a355cb0deb7e9807bea430c4815dc49dd1609d6c45aa741c17c1630c6324` |
| Endpoint observations | `e23804cd211c5f1f733b0d37ae7be3ba9ac130fb9393903b15be8e15702742ec` |
| `capture1.pcapng` | `25445b4192850dcab2ab51c021e48496dc0164f1a0bfa3ae881fab9b02b1c39e` |

NH-E01 remains PARTIAL and Protocol Implementation stays CLOSED.
