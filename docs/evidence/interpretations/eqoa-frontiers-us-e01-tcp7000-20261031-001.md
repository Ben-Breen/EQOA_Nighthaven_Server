# E01 TCP/7000 — initial HTTP request captured

Reviewed 2026-10-31, America/Chicago. Session `E01-TCP-20261031T122522344Z`; [sanitized manifest](../manifests/eqoa-frontiers-us-e01-tcp7000-20261031-001.json), [run card](../experiments/E01-TCP7000-observation.md). This follows the [SYN-only patched observation](eqoa-frontiers-us-e01-20261031-001.md). Scope: the identified Frontiers US `SLUS-20744` / `EEEE1FCC` client in PCSX2 2.8.2.0, with the same prepared card and PNACH.

**Result: PASS for the bounded receive-only observation.** TCP connected to the isolated lab, and the client sent 104 bytes. The byte stream matches the single raw TCP data payload byte-for-byte. The listener sent zero application bytes, closed after three idle seconds and recorded no cleanup errors. The client reached DNAS Status: Done, entered the update flow and subsequently displayed an update error. This does not establish an accepted updater response or complete E01/E02.

## Decoded request and confidence

`CONFIRMED — client/protocol`, limited to this observed request:

| Property | Observed value |
|---|---|
| Network destination | `198.18.0.1:7000` |
| Request method/version | `GET`, `HTTP/1.1` |
| Request target | `/patch/eqoa/eqoa-frontierslive-update.xml.gz` |
| HTTP Host field | `patch.everquestonlineadventures.com` |
| Other request headers | None in the captured initial request |
| Query/body | No query; zero request-body bytes |
| Received application bytes | 104 |
| Sent application bytes | 0 |
| Byte-stream SHA-256 | `8a84e038e8e550ee1a687e216990a2c248434bda0bfa6ae275b021e21e2abb18` |

The legacy name is an HTTP field, not the observed connection destination. The capture shows the socket connecting to `198.18.0.1`; no external HTTP destination is recorded. The PNACH changes the shared resolver result and does not rewrite URL/header strings. Accepting this Host field on an independently controlled lab endpoint does not require contacting the named historical service.

The interpretation used ASCII request/header structure, CRLF termination and a bounded comparison against the original TCP payload. No authorization/cookie header was present. Raw request bytes remain private; the public record contains decoded technical fields and hashes only.

**UNKNOWN:** accepted HTTP status, headers and body; manifest schema, encoding, compression, integrity checks and update decisions. The filename suffix alone does not establish these requirements. An empty body is a hypothesis for a later controlled test. This listener supplied no HTTP response at all, so it did not test acceptance of an empty HTTP response. No manifest/content from Sandstorm or another revival project was fetched or copied. Public patch/install material provides source context, not the missing client response contract.

## Controlled setup and observations

The operator explicitly approved one new receive-only run after requesting the listener. The same PNACH (`94c406a3…101a82`) and prepared N02 output card (`e859bee1…d4c393`) were reused through disposable copies. The prior changed E01 output was preserved separately. The intended functional change was adding the listener and its narrowly scoped firewall rule; the runner hash and evidence paths also changed, so do not describe this as an exhaustive single-variable experiment.

The separately versioned harness passed 103 offline integration tests; the receive-only tool passed ten synthetic/loopback checks, including partial-evidence/error cleanup. These checks did not bind TAP or start a guest. Elevated readiness and independent review preceded the authorized run.

Capture was ready at **12:26:09.392 UTC**, listener readiness at **12:26:14.555**, and guest launch at **12:26:15.985**. The listener bound only `198.18.0.1:7000`, accepted only the guest `198.18.0.2`, permitted one connection and had 64 KiB / 20-second receive / three-second post-data idle bounds. A unique temporary inbound firewall rule restricted local address/port, guest address, TAP interface, helper executable and TCP. External physical adapters were disabled. No application response or update service was implemented.

The 26 TAP frames comprise six ARP, three host multicast UDP, eight reverse-DNS question/REFUSED frames and nine TCP frames. The three-way handshake completed at **12:27:31.420 UTC**. One 104-byte guest data frame followed at **12:27:31.421**; kernel acknowledgement, FIN and closing acknowledgements are recorded. Host TCP frames contain zero application bytes. The raw payload equals the listener file; no truncation was required. Emulator-intercepted DHCP/DNS remain separate semantic-log evidence.

Four F8 images were inspected: DNAS Status: Done at **12:27:27.556**, Reading game data at **12:27:30.769**, Connecting to update server at **12:27:32.432**, and update error at **12:27:36.803**. These are screenshot-write observations, not exact UI transition times. The update error followed a deliberately unanswered HTTP request; its exact error-handling semantics remain UNKNOWN.

## Integrity, containment and recovery

Independent review verified 92 manifest references (61 top-level, 24 embedded run and seven input), with no mismatch. There are 62 restricted EFS session files and three authorization/observer files. The equal file count to the earlier experiment is coincidental: five fewer screenshots are replaced by listener artifacts, with additional inventory differences cancelling. No assets, cards, raw captures, screenshots, source patch or generated PNACH are imported into Git.

The observer recorded 183 capture-interval samples with both physical adapters administratively Down, no unsafe/missing samples and maximum gap 0.562 seconds. This is sampled operational containment evidence, not complete flow or original-hardware proof. Native NAT-table contents remain UNKNOWN; independent stopped-driver/service and route/bridge checks remain in force.

The guest closed normally; collection began **12:27:45.588 UTC**, about 89.603 seconds after launch. Listener, accepted socket and file were closed; zero application bytes were sent. The exact temporary rule was removed before uplink restoration. Original INI was restored byte-for-byte with cheats/networking disabled and original cheat directory selected. Original ISO, prepared source, clean seed, original cards, prior E01 output and both supplied PNACH files retain expected hashes.

A medium-token firewall query was denied and was not treated as verification. A separate elevated read-only check subsequently reported `ROLLBACK_VERIFIED_NO_BOOT`, including absence of the exact listener rule, port and helper, idle PktMon, stopped original DNS state and restored adapter administrative states. No further guest boot was performed.

## Next measurable action

Identify the original client's update-response parsing and no-update acceptance conditions through bounded read-only analysis. Completion evidence: build/source-linked parser locations and an independently specified candidate response with every unverified assumption marked. A future response experiment needs its own authorization; do not implement an updater or serve an invented manifest automatically. Behavior is the research target, not another project's content or code. An optional greeting/news page remains deferred; this update request does not establish the separate NewsURL/MOTD flow.

Full E00 remains PARTIAL under the operator-directed qualified handoff. E01 has two reviewed scoped observations; full bootstrap dependency/differential work remains open. Evidence Acquisition Gate remains OPEN and Protocol Implementation Gate remains CLOSED for the Nighthaven server.
