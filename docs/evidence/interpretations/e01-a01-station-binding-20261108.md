# E01-A01 — Station linked after the updater

Reviewed November 8, 2026 (America/Chicago). Session `E01-A01-20261108T165054763Z`, Frontiers US SLUS-20744 / EEEE1FCC in PCSX2 2.8.2.0. This was one contained TAP run with the same prepared card, independently encoded v1 DNAS/resolver PNACH, TCP/7000 updater responses, and receive-only TCP/9735 probe as the relevant earlier lab work. The only added observation channel was a read-only, process-verified PINE connection over host loopback. The unrun D02 diagnostic patch, debugger and breakpoint recipe were excluded.

## Observations

| UTC | Evidence |
| --- | --- |
| 16:52:04.415 | TAP capture ready before guest boot. Both lab TCP probes were ready before launch. |
| 16:52:38.379 | Stable bootstrap registry and relocated UTIL header/fingerprint identify UTIL at `0x00170E80`. Binding flag 1 and all 28 v1 replacement words match. |
| 16:53:22.780 | Runner reports its first DHCP-send log observation, after readiness. This timestamp is a proxy for network activation. |
| 16:53:44.220 | SETUP target and its registry entry no longer appear in the sampled state. |
| 16:53:45.798 | Bootstrap Station slot, processed extent (`0x0010C154` bytes), registry/SNR identity and relocated `station_main` target agree on base `0x002B6A80` and entry `0x002B6B80`. |
| 16:54:05 | The retained screenshot is black. The operator reports the black screen after DNAS. |

**CONFIRMED — client/protocol**, scoped to the recorded emulator profile. The Station image contains the three expected direct calls in the bounded, reference-derived `TCPSocket::Open` window. The observed call instructions at `0x002EA41C`, `0x002EA448` and `0x002EA46C` target the original bootstrap exports `sceInetName2Address`, `sceInetCreate` and `sceInetOpen`, respectively. The observer recorded 383 usable samples and nine changed states. These instruction reads establish loaded code binding. They do not establish that any of these calls executed.

The TAP record contains 48 frames, with 31 TCP frames all between the lab guest and the lab updater on TCP/7000. Three updater connections carried 220 client bytes and 543 server bytes in aggregate. The listener verified its existing response bytes. No TCP/9735 attempt appears in the TAP record, and the prestarted receive-only probe reports `NO_CLIENT`. Account login was not reached.

**UNKNOWN.** Station was linked, but the trace does not show entry into `station_main`, which login resource opened, whether resource/page initialization succeeded, whether a host was selected, or whether the resolver was called and returned. No selected account destination or failure cause follows from the black screen. The earlier [static account path](eqoa-frontiers-us-account-endpoint-static-20261101-001.md) describes the candidate call order and distinctions from the native port.

## Run outcome and evidence integrity

The v8 harness retained `INVALID_OR_BLOCKED`: it saw its observer thread complete during guest shutdown and classified that completion as unexpected. The readiness marker, complete observer result, listener artifacts and raw ETLs survived. The ETLs were converted offline into a separate restricted EFS review directory. No capture was replayed. The harness reported restoration of the guest, INI, DNS, listeners, firewall and physical adapters and verified the source card, ISO and patch hashes. Independent checks found PCSX2 closed, the original fail-closed INI hash restored, DNS stopped and ports 7000, 9735 and 28121 no longer listening. PktMon's stop record reports no events lost. All 104 manifest references checked against their sizes and hashes, and all 68 session files passed the restricted EFS/ACL checks.

| Restricted artifact | SHA-256 |
| --- | --- |
| Session result | `59e420be8a4df17e5e5bcce9e54176ac6aa1736086f71dacb6aa3250f9dac617` |
| Endpoint readiness | `175101304391107f8248a3fff4384c2ec49186baa04c8e8ef23c7efeede87ff5` |
| Endpoint observations | `b24e8b541a8bec2809ffa820e33d136343f5500132da487efe992f2e400cd4fb` |
| Listener result | `51329f0c89d2b0af3c704968498becdceea578c631c6645b47076605b99d1ff4` |
| `capture1.etl` | `a6a200b0c7a54c5867273ef4a6e42a8773738e265a593178f2d3de92e5283a98` |
| `capture2.etl` | `73069127badbc19a076180f13181c69979e5da836d2c52a02af50dbb72632a25` |
| Black-screen screenshot | `beb2d1ef7b079180dc5ab7aae1babf4b297135298cae022666338c6e9de5d486` |

The observer build SHA-256 is `0fcf01998d5a5ad742a561fbe190d362c15b81decdf5adb3768754254de28a1f`. Packet summaries are interpretations of the private raw captures. A separate v9 runner corrects the shutdown race, preserves the executed v8 package, and passes 115 offline checks. V9 has not been run live.

**NIGHTHAVEN DECISION.** Keep the v1 patch and updater as the control. For the next diagnostic, verify the live Station base again, then use narrowly scoped execution checkpoints at `station_main` and the login-resource open/return path, with the pinned reference's `LoadServers` entry as the downstream checkpoint. Record the actual resource name and return/error, or the last checkpoint reached. A missing TCP/9735 attempt alone does not justify an account response or a new endpoint patch. E01 remains PARTIAL and Protocol Implementation stays CLOSED.
