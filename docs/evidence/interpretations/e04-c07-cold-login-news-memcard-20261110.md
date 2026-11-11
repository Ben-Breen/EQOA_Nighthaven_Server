# E04-C07 — saved-account login and news reach memory-card check

Session `E04-C07-20261111T052950627Z`, November 10 local time. Scope is Frontiers US SLUS-20744 / EEEE1FCC in isolated PCSX2. The operator logged in with the account created in C06 and reported progression through login and news, followed by a hang at a memory-card dialog.

**CONFIRMED — client/protocol**, scoped to this lab configuration. The client sent one 148-byte `0x24` request. The probe verified the decoded password against the persisted MySQL verifier and completed the 168-byte `0x25` reply. The client then closed the account connection. No account was created during C07. This establishes the saved-account cold-start check for the corrected verifier and the observed transition after the login reply.

The HTTP listener completed the manifest, two Changes replies and two 151-byte news replies. Both news replies matched the candidate. The first screenshot visibly renders text and closing HTML tags from the lab page, with a Continue control. The operator reported that it looked odd. A plain-text candidate is appropriate to test the cosmetic presentation. Necessity of particular news contents remains **UNKNOWN**.

The second screenshot reads “Checking memory card (PS2) in MEMORY CARD slot 1. Do not remove memory card (PS2), reset, or switch off the console.” The emulator log records audio teardown and initialization between the screenshot milestones. Its log records a working-card save earlier in the run. These observations do not identify the later wait's cause or prove its completion. The existing execution trace covers Station checkpoints and supplies no checkpoint for the memory-card wait.

The first capture contains 64 decoded TCP frames and eight guest-related UDP/DNS frames. All decoded guest UDP in this capture uses the lab DNS endpoint. There is no captured guest game-UDP exchange at this TAP boundary. The second capture contains zero decoded TCP frames and no guest UDP frames. Server-selection rendering and character flow remain unverified. An absent TAP flow does not establish complete coverage of emulator-internal operations.

All 130 references across the input, run and session inventories passed size and SHA-256 checks. The runner finished normally and all restoration flags passed. Raw captures, screenshots, card outputs and credential data remain restricted outside Git.

First pcapng SHA-256 `b3044a5359f0454c37f6a8984dea19eff0a4ef3ee965dc48db22f3cbfee19de6`. News screenshot SHA-256 `8e17a1e387bc6f4015c7f1c965ee0375107f83a4af846587d40139f816fe91a5`. Memory-card screenshot SHA-256 `eabfeeaee0029d06f7efb478241a8909c6d59c95375624d64e37e99f92272e4a`. Session result SHA-256 `7e80d89c663dc892ccdebb263fa9ee9a54eea21df30ec2263bacb31d314c56a1`.

## Next focused investigation

Use the saved emulator log and disposable card output first. Locate the post-Station transition, the operation behind the displayed card check, and the expected completion or error branch. Check client/module startup and card I/O before adding a server-selection response. If a live run is required, trace that operation and its return in the current contained setup. The objective is a verified route from successful login/news to a visible server-selection screen.
