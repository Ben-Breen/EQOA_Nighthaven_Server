# E01 — receive-only lab TCP/7000 observation

Prepared and collected 2026-10-31. **COMPLETE for one bounded receive-only observation**, following explicit new-run approval. The [result](../interpretations/eqoa-frontiers-us-e01-tcp7000-20261031-001.md) and [manifest](../manifests/eqoa-frontiers-us-e01-tcp7000-20261031-001.json) record a completed handshake, 104-byte HTTP request, zero application response bytes and verified rollback. No Nighthaven game/update/account service is implemented by this tool. The procedure below grants no automatic repeat or response experiment.

## Question and prerequisite

The questions below describe the pre-run evidence. The linked result records the subsequent observed HTTP request; response acceptance remains UNKNOWN.

`CONFIRMED — client/protocol`, scoped to the previous modified PCSX2/client profile: five TCP SYNs target `198.18.0.1:7000`; no TCP response or application data was captured. `UNKNOWN`: what the client sends after TCP connects, whether it speaks first, and the application protocol. Do not assume HTTP, a request path, a response format or an updater implementation.

Objective: accept one isolated guest connection and preserve its first application bytes, or record a bounded no-data result, without synthesizing an application response.

Reuse the exact previous input pair: prepared card SHA-256 `e859bee1de08dcaa861c1f29aca1396f4a3f7b0a847eadc1a1d7243779d4c393` and candidate PNACH SHA-256 `94c406a3a4a6106d7cacc65af8b41d8aaae734da51ca05fa9ec42787bd101a82`. Copy the prepared card to a disposable working card; do not use the previous run's changed output as an unrecorded replacement. Preserve the source ISO, cards and supplied patches. No extra E00 baseline is required.

## Setup and boundaries

- Recheck elevated readiness, idle owned capture facilities, existing EFS/operator-only storage, exact TAP identity, route/forwarding/bridge guards and prior restoration.
- Use the separately reviewed listener harness. Temporarily disconnect physical uplinks under the specific new-run authorization; no production DNS, adapter address or global firewall policy changes.
- Start TAP capture before guest boot. Bind only `198.18.0.1:7000`; a temporary inbound rule must be scoped to that local address/port, TCP, the owned helper executable, TAP interface and guest `198.18.0.2`.
- Accept one connection from the guest only. Collect at most 64 KiB. Accept deadline: 300 seconds; receive deadline: 20 seconds after acceptance; stop after three idle seconds following received data, earlier peer close or operator stop.
- Send zero application bytes. Kernel TCP acknowledgements are expected transport behavior, not an application response.
- Keep raw stream bytes, transport capture, logs, configuration, consent and hashes in controlled storage outside Git. The byte stream concatenates reads; raw packet boundaries remain authoritative in the capture. Record byte-limit truncation explicitly.

The same TAP-only recursion-Deny DNS fallback may remain for comparability; it is not a permanent Nighthaven dependency. Intercepted emulator traffic remains a capture limitation.

## Action and stop conditions

After explicit authorization for this new captured run, cold boot the prepared isolated profile, accept the EULA if prompted, choose Play and the saved network profile, and use F8 at DNAS/update/result screens. Do not enter account credentials or switch cards. Close normally after the observed result, or at the 300-second guest limit. Listener completion does not authorize another connection or guest run.

Stop for failed containment/capture, unexpected peer, changed input, unknown listener ownership or incomplete cleanup. Preserve partial bytes on receive/reset errors. A failure must produce diagnostics and must not be relabeled a successful capture.

## Observations and interpretations

| Result | Interpretation | Still unknown |
|---|---|---|
| Handshake and initial bytes captured | Client emission is established for this exact environment; raw bytes become evidence for a decoder hypothesis | Required response, full exchange, necessity across builds |
| Handshake, no bytes within bounds | Bounded connected/no-data observation | Server-first behavior, timing, omitted dependency or another cause |
| SYNs without handshake | Endpoint/transport setup remains unresolved | Firewall/routing/listener cause; application behavior |
| Captured prefix reaches size/time limit | A bounded prefix exists; mark incomplete/truncated | Remainder and complete message framing |

A parseable-looking prefix alone does not establish a universal protocol. Retain exact provenance and assumptions; do not publish credentials, tokens, proprietary payloads or raw captures.

## Recovery and completion evidence

Stop the owned guest and listener, verify closed sockets/process identity and the final listener report, remove only the uniquely named and verified temporary firewall rule, stop owned capture, restore the original profile with cheats/networking disabled, restore temporary DNS, then restore only saved physical administrative states. Uncertain listener/rule cleanup must hold uplink restoration for recovery review.

Complete this experiment only after reviewing capture, listener bytes/count/hash, accept/read/close timing, screen state, source preservation and recovery. A no-data or failed-handshake result can complete a bounded observation without proving the application protocol. No updater response or broad server functionality is authorized by this run card. Protocol Implementation Gate remains CLOSED for the Nighthaven server.
