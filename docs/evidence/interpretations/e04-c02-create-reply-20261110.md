# E04-C02 — client accepts the synthetic creation reply and proceeds to login

Session `E04-C02-20261111T005622940Z`, November 10, 2026 local time. The isolated Frontiers US SLUS-20744 / EEEE1FCC run reused the A07 startup path and tested the client response to a single synthetic account-creation reply. The operator reported that the client accepted the reply. The probe had no database integration.

**CONFIRMED — client/protocol**, scoped to this session. One TCP/9735 connection carried these application messages in order:

| Direction | Declared length and captured bytes | Big-endian type |
| --- | --- | --- |
| Client → lab | 476 | `0x38` |
| Lab → client | 276 | `0x29` |
| Client → lab | 148 | `0x24` |

The client acknowledged the complete `0x29` reply at TCP level and then sent `0x24` on the same connection. The receive file contains exactly the two client payloads, in order. The lab reply matches the candidate hash and contains big-endian length 276 at offset 0, big-endian type `0x29` at offset 4, and big-endian 16-bit `1` at offset 12. All remaining bytes are zero. The next request is consistent with the independently captured [L01 login](e04-l01-login-request-20261110.md). The candidate username and credential slots from [C01](e04-c01-create-user-name-20261110.md) and L01 match byte-for-byte between the two C02 requests. This comparison covers one creation-to-login flow. Credential encoding, repeatability across sessions and a verifier design remain **UNKNOWN**.

**CONFIRMED — reference.** `AuthenticationServer/Account/AccountMessages.cs` builds the response used as the candidate. The `SwapBytes(1)` call resolves to the `ushort` overload in `AuthenticationServer/Utility/Utilities.cs`. The accepted reply and observed follow-up establish progression to a login request in this configuration. Persistence, successful login and server selection remain unverified.

All 121 inventory references across the input, run and session records passed size and SHA-256 checks. The runner reported normal close, all restoration checks passed, and source card, ISO and patches preserved. Raw packet data and screenshots remain in restricted storage.

First pcapng SHA-256 `f89374a71dd6c5b4cb753f3d70fa1db8ea2049c5c8136dce15cb9adeb4a4f8b9`. Reply SHA-256 `23ba6e7c943872d5d876d3949ab3040146449649ddc03fcec2b8d14b377e6874`. Combined receive file SHA-256 `dafaa3befc7e8e8e1391f9d93b41764e86ebf5312e4a7a9b4fed5d2fd4918d50`.
