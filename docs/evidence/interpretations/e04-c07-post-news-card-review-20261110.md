# C07 post-news client and memory-card review

Reviewed the saved session `E04-C07-20261111T052950627Z` after the [cold-login/news result](e04-c07-cold-login-news-memcard-20261110.md). This inspection used the emulator log, observer metadata, preserved prepared card and disposable card output. The card decoder read both images without changing their hashes. No guest was launched during this review.

## Saved artifacts

**CONFIRMED — client/protocol**, scoped to these lab artifacts. The prepared card and C07 output both have 14 active regular files overall and the same six EQOA files under `/BASLUS-20744EQONLINE/`.

| EQOA file | Size | C07 comparison with prepared source |
| --- | --- | --- |
| `icon.sys` | 964 bytes | Same hash |
| `static.ico` | 96,408 bytes | Same hash |
| `pad.dat` | 2,965,504 bytes | Same hash |
| `BASLUS-20744EQONLINE` marker | 8 bytes | Same hash |
| `game.opt` | 1,024 bytes | Same hash |
| `session.id` | 8 bytes | Different hash |

The decoder successfully traversed both filesystem inventories and their allocated file chains. Each image has 3,050 allocated clusters within an allocation extent of 8,135, leaving an estimated 5,085 unallocated 1-KiB clusters. This decoder does not check or correct ECC. These results establish readable filesystem metadata and file contents for the named files. They do not establish a successful runtime card-status call.

Neither card contains `eqahosts.txt`, `althosts.txt`, `WORDS.WAD` or `WORDS.TXT` in the EQOA directory. The same allocated paths are present before and after the run. The source card's unchanged content does not supply evidence for an original updater's complete file requirements.

The input configuration enables card slot 1 with the disposable `EQOA-E01-active.ps2` and disables slot 2. The run log records card saves at emulator-relative 55.917, 68.703 and 93.700 seconds. It records audio teardown at 103.259 seconds and initialization at 106.210 seconds. The second screenshot shows the card-check dialog roughly 150 seconds into the run.

At `05:32:27.003 UTC`, observer metadata no longer identifies Station in the active registry. At `05:32:28.834 UTC`, it records active module pointers `0x003E3D00`, `0x002A8180` and `0x00566B00`, and the bootstrap's client call target `0x00679030`. This records a resolved target and registry change. Execution of that entry and the exact owner/state of the later dialog remain **UNKNOWN**.

The log lacks the reference's named completion messages for same/different card session, words loaded, shard list loaded and client entry. The current trace has no execution checkpoints for those operations. Absence of text in this log cannot prove which operation failed or waited.

## Source-informed startup sequence

**CONFIRMED — reference**, scoped to public analysis revision `e803a6abd9b038c758603dc0f236561906d5530b`.

1. The client card-initialization window starts the memory-card error/check window on screen 4. Its later states reload words, load game options, load shard-host entries and show the next login window. These transitions are behind card-status checks. [Client startup window](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/client/src/viwndinitfrommc.cpp)
2. The check window counts 40 draw frames before calling card status. A ready or changed formatted card then enters session comparison. A matching session exits the check window and notifies its owner. Other results select different card-error screens. [Card-check state machine](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/mcerr/src/viwndmcerr.cpp)
3. Card status issues `sceMcGetInfo` and waits through `sceMcSync`. The session comparison reads eight bytes from `session.id` and compares them with the current in-memory session ID. The saved image cannot establish that in-memory value. [Card I/O layer](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/src/vimemcard.cpp), [Session comparison](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/mcerr/src/viwndmcerr.cpp)
4. Word loading has original-disc fallbacks after the card resources. The missing word files on the card therefore do not establish a missing required download. [Word-loading fallbacks](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/src/viui.cpp)
5. The later shard-host step reads `althosts.txt`, then `eqahosts.txt` from the card. The inspected routine returns failure if both reads fail and has no disc fallback. **INFERRED:** the missing host configuration is a later obstacle if this client follows that path. Its execution in C07 remains **UNKNOWN**. [Host-file lookup](https://github.com/DabDavis/eqoa-decomp/blob/e803a6abd9b038c758603dc0f236561906d5530b/modules/client/src/viwndinitfrommc.cpp)

## Next evidence gate

The next focused runtime observation should locate the first unresolved operation in this sequence. Validate live module placement and instruction signatures before using reference addresses. Retain the existing account and news behavior for that comparison.

| Observation | Decision it enables |
| --- | --- |
| Check-screen entry, draw counter, and whether the 40-frame branch executes | Distinguish window scheduling from card I/O |
| `VIMemCardStatus` entry/return and `sceMcGetInfo`/`sceMcSync` completion | Identify a card-status wait or returned error |
| Session comparison result and the read length for `session.id` | Establish session agreement without recording session values |
| Check-window exit and owner completion callback | Establish that client startup can advance |
| Word, option and host-file load names and return values, if reached | Identify the actual next resource failure |

**NIGHTHAVEN DECISION.** Use that trace to select the correction. If host configuration is the first demonstrated file failure, author only a Nighthaven endpoint file and deliver it through a scoped client-compatible path. Proprietary vocabulary, world data and revival-project resources are excluded from that proposed configuration work. Server-selection rendering and character creation remain open.

## Provenance

The restricted artifacts remain under the C07 session directory. Source card SHA-256 `e859bee1de08dcaa861c1f29aca1396f4a3f7b0a847eadc1a1d7243779d4c393`. Output card SHA-256 `cea9bc9d3fc583a8563b9595a752e20edc26b5ef0af2a79261946892ed58d9c0`. Emulator log SHA-256 `b9a0f3491fedacec412cbf63cacf59852706f188d4cede4eadcba457c507d573`. Observer JSONL SHA-256 `e95e28c0b285a56944177936189dbe5d055922dbbb02869b36d25c431d2842c9`. Read-only card decoder SHA-256 `d3ad90015272b0bf646ee4cda1a539dee1e01137b2d7d3516b29e2145b73785b`.
