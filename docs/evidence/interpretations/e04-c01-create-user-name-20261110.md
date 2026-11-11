# E04-C01 — Create User Name submission captured

Session `E04-C01-20261111T004009600Z`, November 10, 2026 local time. Scope is Frontiers US SLUS-20744 / EEEE1FCC in isolated PCSX2. The emulator, PNACH, source card, ISO, BIOS and updater response fingerprints match [L01](e04-l01-login-request-20261110.md). The operator reported two forms collecting name, ZIP code, email, username, password and date of birth.

**CONFIRMED — client/protocol**, scoped to this submission. The guest completed the TCP/9735 handshake at `00:42:05.476 UTC`. At `00:43:54.692 UTC`, it sent one 476-byte TCP payload. The probe recorded exactly the same bytes. The first two big-endian 32-bit fields contain length `476` and type `0x38`, matching the reference `SUBMIT_ACCT_CREATE` identifier. This was the sole decoded client payload on TCP/9735 in the capture. The host acknowledged it at TCP level and sent zero application bytes. The probe stopped on operator close. Account creation, the accepted response and any validation required between or after the forms remain unverified.

| Byte offsets, inclusive | Capture and reference comparison |
| --- | --- |
| 0–3 | Big-endian `476`, matching the captured length |
| 4–7 | Big-endian `0x38`, matching `SUBMIT_ACCT_CREATE` |
| 8–11 | Read as an additional header word by the reference. Meaning **UNKNOWN** |
| 12–43 | Populated printable prefix with NUL termination and zero padding. **INFERRED** username slot from the reference parser |
| 44–75 | Populated 32-byte region. **INFERRED** credential slot from the reference parser. Encoding and verification algorithm **UNKNOWN** |
| 76–347 | **UNKNOWN**. The reference skips these bytes. The operator's list of form fields does not establish their offsets or validation rules |
| 348–475 | Populated printable prefix with NUL termination and zero padding. **INFERRED** email slot from the reference parser |

**CONFIRMED — reference.** `AuthenticationServer/Account/ProcessAccount.cs` parses `0x38` at those offsets. `AuthenticationServer/Account/AccountMessageTypes.cs` names `0x29` as the account-creation response. Its successful use remains unverified for this client.

The forms and wire request inform the application input. Persistence requirements are a separate Nighthaven decision. For a minimal lab account, the operator favors retaining only what is needed. The candidate persistent fields are an internal account ID, username and credential verifier once verification is understood. Email would serve a chosen feature such as account recovery. Name, ZIP code and date of birth have no demonstrated storage requirement in this capture.

All 120 inventory references across the input, run and session records passed size and SHA-256 checks. The runner reported normal closure, source card and ISO/patch preservation, and all restoration checks passed. Raw packets, submitted values and the screenshot remain in restricted storage.

First pcapng SHA-256 `3d07825296731a891149f9ea88c907afa8f6d4cdc41d305a73c78e75f0b55e74`. Probe payload SHA-256 `cfc80b8e4746c097f0847fad56cce56b71bb984741d53351340712868bc92a6a`. Screenshot SHA-256 `f6c0bf96db06f4622edbeb757d8dc43a3bb87ee12754aa30da140b1d8d711a93`. Session result SHA-256 `bb469ad848d112afb56366b50ff330ebc261c41fc609a31ae19ed040c652dc08`.
