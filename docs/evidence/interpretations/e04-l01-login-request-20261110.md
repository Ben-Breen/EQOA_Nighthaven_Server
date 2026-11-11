# E04-L01 — TCP/9735 login request captured

Session `E04-L01-20261111T003008906Z`, November 10, 2026 local time. Scope is Frontiers US SLUS-20744 / EEEE1FCC in isolated PCSX2. The run and [A07 run 1](e01-a07-login-screen-20261108-001.md) have matching emulator, PNACH, source card, ISO, BIOS and updater response fingerprints. L01 used the longer receive-only account probe.

**CONFIRMED — client/protocol**, scoped to the two captured submissions. In L01 the probe accepted the TCP/9735 connection at `00:32:14.689 UTC`. The guest sent 148 application bytes at `00:32:43.112 UTC`, about 28.4 seconds later. The host acknowledged the segment. The probe recorded the same 148 bytes byte-for-byte, sent zero application bytes and closed after its idle-after-data interval. The final screenshot shows a request timeout on the login form. The first TAP capture contains 36 TCP/7000 frames and seven TCP/9735 frames. The second contains no decoded TCP frames.

L01 and [A07 run 2](e01-a07-login-submission-20261108-002.md) each contain one 148-byte client segment with big-endian `148` at offset 0 and big-endian `0x24` at offset 4. The declared length matches the captured payload size in both runs. This supports the length and type interpretation for these requests. TCP stream handling for split or combined application messages remains untested.

| Byte offsets, inclusive | Observation | Interpretation |
| --- | --- | --- |
| 0–3 | Big-endian 148 in both submissions | Declared length matches the captured request size |
| 4–7 | Big-endian `0x24` in both submissions | Reference `LOGIN_REQUEST` identifier |
| 8–15 | Identical between the two submissions | Meaning **UNKNOWN** |
| 16–47 | Different printable prefixes with NUL termination and zero padding | **INFERRED** username slot, consistent with the reference parser |
| 48–79 | Different 32-byte region | **INFERRED** credential slot from reference alignment. Encoding and algorithm **UNKNOWN** |
| 80–83 | Identical between the two submissions | Meaning **UNKNOWN** |
| 84–147 | Same four printable bytes followed by zeros | Reference calls this `GameID`. Exact meaning **UNKNOWN** |

**CONFIRMED — reference.** The historical `AuthenticationServer/Server/Client.cs` reads the two big-endian header fields. `AuthenticationServer/Account/AccountMessageTypes.cs` labels `0x24` as `LOGIN_REQUEST`. `AuthenticationServer/Account/ProcessAccount.cs` parses the body at the offsets above. Its optional DES path is implementation evidence. The captured request comparison leaves the client credential algorithm and key unresolved.

The probe and TCP evidence establish the outgoing login request. Authentication, account creation, and an accepted server response remain unverified. **Create User Name** is a separate client path to capture.

All 120 inventory references across the input, run and session records passed size and SHA-256 checks. The runner reported normal closure, source card and ISO/patch preservation, and all restoration checks passed. Credential values, the raw request and the screenshot remain in restricted storage.

First pcapng SHA-256 `47251647a64c18e8fb5d59356432748296972c358aa30c3bc75cb026ca8a673d`. Probe payload SHA-256 `7b145aefbdea6d2ffa4322b5b33c58b96cf8ed39d6fa3de1fd2cab1fcb5d4754`. Screenshot SHA-256 `a636f134754698938082f0092243d69a8aef74dc264f2faf7be645aa0824501c`. Session result SHA-256 `176f220dd767bb3b9d7b987503ece85abb807932d31365c5cd25fa64eb54342b`.
