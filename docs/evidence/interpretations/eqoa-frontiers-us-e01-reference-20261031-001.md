# E01 reference capture — online Sandstorm-configured client

Reviewed 2026-10-31. **COMPLETE for one scoped reference observation; E01 remains PARTIAL.** [Manifest](../manifests/eqoa-frontiers-us-e01-reference-20261031-001.json) registers `E01-REF-20261031T192009001Z`. The operator authorized this separate online capture and reported reaching **account login** before closing. No screenshot was available, so that screen is operator-reported rather than independently visually verified. No credentials were requested. Raw captures and all response content remain restricted/EFS outside Git.

## Scope and result

**CONFIRMED — client/protocol**, only for this patched Frontiers US EEEE1FCC / PCSX2 2.8.2.0 / external Sandstorm environment: 27 captured TCP frames contain three reassembled exchanges with the configured external endpoint on TCP/7000. The initial 104-byte request is byte-identical to the Nighthaven lab request (SHA-256 `8a84e038e8e550ee1a687e216990a2c248434bda0bfa6ae275b021e21e2abb18`).

| Exchange | Observed response | Body evidence |
|---|---|---|
| Update XML request | HTTP/1.1 200 OK; Content-Length 463; Content-Type application/x-gzip | 463-byte gzip body; CRC/size validation succeeds; decompresses to 1,258 bytes of XML |
| First `/patch/eqoa/Changes.txt` request | HTTP/1.1 200 OK; Content-Length 119; Content-Type text/plain | 119 bytes; content retained privately |
| Second identical Changes request | HTTP/1.1 200 OK; same length/type | Same body hash as preceding Changes response; reason for repetition UNKNOWN |

The XML has `VerantPatcher` → `Product`, with `Distribution`/`File` and `Changes` elements. Attribute names include version, file-location, size and CRC fields; their minimum requirements and semantics remain UNKNOWN. Only structural names and hashes are registered, without copying attribute values, manifest text, change messages, executable patches, resources or game content.

**INFERRED:** this environment progressed beyond updating with a nonempty gzip/XML response and separate Changes exchanges, supported by the capture sequence and operator's account-login report. This does not prove that gzip, every header/element, listed file or Changes content is mandatory. The different patch/card/BIOS/settings and remote service prevent an exhaustive single-variable comparison with Nighthaven's failed empty response. This is neither original SOE server behavior nor authoritative Nighthaven architecture.

## Capture and preservation

Capture preceded emulator launch on the configured physical Wi-Fi component, filtered bidirectionally to the known external IPv4/TCP/7000 endpoint. No DNS, adapter, firewall, lab profile, ISO or patch configuration was changed. Capture is not process-exclusive or complete coverage of other endpoints. Packet Monitor reports no lost events. Its converted file declares Ethernet but contains native Wi-Fi data headers; a scoped decoder checks each data/LLC/IPv4 layout and TCP lengths, rejects stream gaps/conflicting retransmissions, and verifies complete gzip content. This says nothing about over-the-air encryption.

All eight original inventory references match. The 16 raw/derived files remain EFS encrypted with operator/SYSTEM-only access. Capture stopped on normal closure and its temporary filter was removed. Nighthaven's profile hash is unchanged. Box1's INI, Frontiers settings and published PNACH hashes are unchanged; its active memory card changed during normal play and was not rolled back. The original Nighthaven lab/source cards were not used.

Earlier preflight stops made no capture changes. Separate attempt `E01-REF-20261031T191742256Z` hit an ISO launch error and captured no matching packets; it is not a protocol result. The verified native Windows ISO path resolved the subsequent launch, without establishing the precise internal cause of the earlier path error.

## Next task and deferred tooling

Inspect updater parsing/acceptance conditions offline, using this successful external response only as comparative evidence. Define an independently authored minimal manifest candidate and a separate Changes resource only after documenting required fields and remaining hypotheses. Do not replay Sandstorm content or make its infrastructure a Nighthaven dependency. No further live experiment is automatically authorized.

The operator suggested a future separate generator and explicitly requested **no implementation now**. That idea remains deferred: the observed gzip body contains XML, while Changes.txt is separate plain text. A future tool could produce both from Nighthaven-owned inputs once the required manifest contract is established; a Changes file alone is not evidence of sufficient manifest input. Greeting/news content remains optional in project intent; whether a Changes resource is required to advance this client remains UNKNOWN.

Architecture Gate #2 **PASS carried forward**; Evidence Acquisition Gate **OPEN**; Protocol Implementation Gate **CLOSED**. E00/E01 remain **PARTIAL**. Account handling and client-driven character creation remain future evidence/implementation work.
