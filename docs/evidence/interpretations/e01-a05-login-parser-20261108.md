# E01-A05 — Station initializes, then login-page parsing fails

Reviewed November 8, 2026 (America/Chicago). Lab session `E01-A05-20261108T183703695Z`, Frontiers US SLUS-20744 / EEEE1FCC. The isolated run used the existing v1 patch, prepared card clone, updater and receive-only account probe. A private PCSX2 2.8.2 build added a host-side execution logger. It did not use debugger pauses or add guest writes. Build source was pinned to `fd9d310ccbb6b8b62c976da8886a3c8fd3a10ff3`.

The network-disabled synthetic control `E01-TraceControl-20261108T183240211Z` used an independently generated ELF that returned `0x12345678`. The logger recorded that value at the expected EE PC `0x002B6C98`, after both entry controls. The synthetic ELF SHA-256 is `4916f0cab75eef7f3222c6e899f32c05932a4678232ce3349e6d0ec03bd79630`. The synthetic run establishes that this logger can record the register at execution, within the controlled fixture.

## Observed in Frontiers

**CONFIRMED — client/protocol**, scoped to this emulator and run. The logger checked the live Station placement and linked calls. It verified the exact login filename in bounded memory before accepting the parser return and verified the live parser JAL at the return site.

| Emulator log time, seconds | EE PC | Event |
| ---: | --- | --- |
| 27.7258 | `0x00101630` | Setup call checkpoint executed. |
| 95.2671 | `0x002B6B80` | Station entry executed. |
| 98.1910 | `0x002B6C98` | Station Init returned `v0 = 0x00000000`. |
| 98.9042 | `0x002CB56C` | Loose-file parser returned `v0 = 0x00000000` for the login page. |

The [A03 resource and callsite review](e01-a03-station-checkpoints-20261108.md) establishes the reference interpretation of these return values. Init passed. The loose-file parser returned no page object for `data/ui/login.xml`. The 48 TAP frames contained 30 TCP frames, all on the lab TCP/7000 updater path. The updater exchanged 220 client bytes and 543 response bytes. The account probe saw `NO_CLIENT`. No TCP/9735 attempt appears on TAP.

**UNKNOWN.** The trace did not record which Station archive was opened, the archive lookup result or why the loose-file parser returned null. The matched reference falls back to the loose path when archive lookup produces no matching record. The original disc archive contains the exact login entry. Together, these observations narrow the next question to archive open, registration or lookup. They do not establish that the archive was missing or that a particular path rewrite would fix the failure.

## Evidence and restoration

The trace executable SHA-256 is `5a6a5494d5063899390d7e919b901854c6141b8ca6dc261e8816d454fe513339`. The restricted runtime log SHA-256 is `fe80e42b56efebc9b5ef23ee17fa1729a207d5c4c8af291ab2f3790c327197a8`. The first pcapng SHA-256 is `e52aacc2e2532f6bc827636266c294fa23794e245abd86a68c87745e02f7e796`. Session manifest SHA-256 is `2543e250751f4026e91d9a21dfe5ebdccb1bd44e1c940aaa68df1992986668c3`. Raw records remain in restricted storage outside Git.

The runner recorded a normal operator close, source-card/ISO/patch preservation and restoration of DNS, firewall, listeners, and physical adapters. The trace INI hash returned to its fail-closed value.

**NIGHTHAVEN DECISION.** Trace the actual archive open and its return, then the matching login lookup. Keep the working patch and updater as controls. The observed failure is before an account connection. NH-E01 remains PARTIAL.
