# E04-C03 and C04 — account persistence and cold-start login

Reviewed November 10 local date. Both sessions used Frontiers US SLUS-20744 / EEEE1FCC in the isolated PCSX2 lab. Submitted values, verifier contents and raw captures remain restricted.

## C03 — creation and immediate login verified

Session `E04-C03-20261111T042739386Z` committed the disposable account and its salted, self-describing verifier of the 32-byte credential field into `nighthaven_test`. The account probe recorded a 476-byte `0x38` request, a completed 276-byte `0x29` reply, a 148-byte `0x24` login request and a completed 168-byte `0x25` reply. It verified the login credential against the saved row and used the persisted account ID in the reply. The operator reported successful creation and observed the account in the database.

**CONFIRMED — client/protocol**, scoped to this modified client and lab test. After the account exchange the client requested `/patch/web/eqoa/motd/news.html` over TCP/7000 with legacy Host `patch.everquestonlineadventures.com`. That request fell outside C03's updater allowlist. The listener failed, the harness closed the guest and the run was classified `INVALID_OR_BLOCKED`. All restoration flags passed and source card, ISO and patches were preserved. The classification does not erase the independently recorded account sub-results. Server-selection rendering remains unverified.

## C04 — cold-start credential mismatch and retry limitation

Session `E04-C04-20261111T043819160Z` tested a saved-account login with an independently authored candidate news page available. The first capture contains 34 TCP/7000 frames and 22 TCP/9735 frames. The host served the usual manifest and two Changes requests. The client made no news-page request in the decoded HTTP exchange records.

**CONFIRMED — client/protocol**, scoped to the captured requests. The guest completed TCP/9735 connection establishment at `04:40:06.129 UTC`. It sent a 148-byte `0x24` login request at `04:40:23.978 UTC` and another at `04:40:51.555 UTC`. Both requests are identical. Their username slots match C03; their credential slots differ from C03. The database still verifies the original C03 credential field and rejects the C04 field. The probe sent zero application bytes. The probe's one-creation-followed-by-one-login rule rejected the second standalone login and closed the connection. A third 148-byte segment arrived after that close and received a reset, followed by unanswered connection attempts. The final screenshot shows “Could not connect to the server.”

The operator subsequently reported forgetting the original password and trying variations. **UNKNOWN:** whether any attempt used the original password. This run cannot determine whether equal password inputs produce stable credential bytes across cold starts. The current verifier checks the opaque 32-byte field. The underlying password encoding remains unresolved. Successful cold-start login and the news response remain unverified.

The parent status says `COLLECTED_PENDING_REVIEW`, while the nested account probe records `FAILED`. Both must be retained when interpreting this run. All 120 inventory references across the input, run and session records passed size and SHA-256 checks. DNS restoration and unchanged non-log configuration checks passed, and all session restoration flags passed.

C04 first pcapng SHA-256 `d63de8cc0daad22ad77cd067674076076ea40381d666226ffd5dc448db6d42ba`. Probe payload SHA-256 `aa72371f27b7c79fc21854122ab079bb4287663f8f543a2908d9cf02f6783bac`. Screenshot SHA-256 `309ed5fd061191a6827b99b225b14797be1f3360b181dbeefc1cc251d51fb354`. Session result SHA-256 `f837eb2fcb0920cbf084c446161877e32a9efaee7de829b36964cd5ca2f2ecb5`.

## Next evidence

Use a known disposable password recorded securely by the operator. Verify creation, immediate login and cold-start login with the exact same input. Correct the probe's handling of standalone login retries before the next run. Preserve the account verifier separately from any operator-controlled recovery copy of test credentials.

## Later C04 account-creation run and C05 preparation

Session `E04-C04-20261111T045343987Z` recorded persistence and successful immediate login verification. The account probe received 920 bytes, sent the completed 276-byte creation and 168-byte login replies, and stopped with `OPERATOR_STOP`. The operator reported a timeout. The probe's two-message processing limit left the later received bytes unprocessed. The updater recorded the manifest and two Changes responses. Its news candidate remains unverified in this session. All restoration flags passed. First pcapng SHA-256 `9a813a91459687b4b6f3beeca541f7d2d522bb4f434df8c5c9e7c124ae071b50`.

The operator requested C05 with unlimited listener timeout. The disposable C05 package disables account and HTTP receive elapsed-time and idle cutoffs, and processes subsequent supported account requests. Normal operator close and stop markers still end the run. The package passed 119 harness checks, account framing and repeated-login loopback checks, and cancellation of an idle account connection through the stop marker. C05 has not run at preparation time.

## C05 — correct password rejected by the opaque-field verifier

Session `E04-C05-20261111T050529815Z` captured one 148-byte login request, sent zero account application bytes and stopped with `OPERATOR_STOP`. All restoration flags passed. The operator confirmed entering the correct password. Its username matches the later C04 creation, while only the first eight bytes of the 32-byte credential field match. The verifier had hashed all 32 encrypted bytes. First pcapng SHA-256 `4bdea5c7063b35c9f5c74fce5d9489f63ef0493f4b37f8698ad713f6ae4cb5ed`.

The pinned public client analysis describes a fixed-string DES key derivation, CBC wrapping with key as IV, and a 32-byte credential input. The historical server crypto wrapper trims the decoded input at its first NUL. **CONFIRMED — client/protocol**, scoped to the two saved lab fields. Offline decoding of the later C04 creation and C05 login produced equal nonempty password bytes before the first NUL and different bytes after it. Password values were kept in memory and excluded from the review output. The opaque-field verifier rejected equal passwords because of the extra bytes. [Client API analysis](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/vistationapi.cpp), [DES wrapper analysis](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/station/src/crypto/des_soe.c)

C06 independently decodes the credential and stores a salted verifier of the bytes before the first NUL. It uses a new verifier identifier and requires a fresh disposable account or an explicit migration of an older lab row. The package passed 119 harness checks, synthetic tests with changed bytes after the terminator and a wrong password, repeated-login framing tests, and an offline equality check against both real captures. C06 client acceptance remains pending. Raw evidence and recovered password bytes were excluded from Git.

## C06 — verification works; repeated news request unanswered

Session `E04-C06-20261111T051757098Z` persisted the account and verified two subsequent logins. The account probe recorded 772 client bytes and 612 response bytes, with completed creation and login reply writes. The operator reported progression to “Getting news,” where it hung. The HTTP listener served the manifest, two Changes requests and the first news request. Its news response was 151 bytes and matched the prepared candidate. The capture also records a second 90-byte news request on another connection. The four-request processing limit left that request unanswered while the listener waited for operator closure. Acceptance of the first HTML body's contents remains **UNKNOWN**.

The runner finished with all restoration flags passed. First pcapng SHA-256 `1c0ce73bcb21b130231320bd7b09c7ccb8c154207da49b5c1f4d1ddc59643dbe`. C07 removes the HTTP request-count limit and retains exact approved request shapes and reply hashes. A loopback test verified nine consecutive replies including repeated news requests after the fourth, followed by stop-marker cleanup. The package and 119 harness checks passed. A saved-account cold start and server-selection rendering remain pending.
