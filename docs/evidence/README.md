# Protocol evidence workspace

This directory is for Nighthaven protocol evidence manifests, sanitized interpretations and reviewed fixtures when collection begins. **No packet captures, client images, game assets or protocol fixtures were created by the research-planning pass.**

## Pass #5 checkpoint

[Pass #5 status](../pass5-status.md) registers the first static client-artifact observations and a prepared E00 run card. Static manifests use `source_kind: static_client_artifacts`, `method: S`, and null capture/network fields. Their verification describes artifact bytes or static code only; interpretation labels remain INFERRED/UNKNOWN as appropriate. They are not reference-server claims or CONFIRMED — client/protocol observations. No raw artifacts or packet fixtures are imported by this checkpoint.

The 2026-10-28 [E00 runtime manifest](manifests/eqoa-frontiers-us-e00-offline-20261028-001.json) and [review](interpretations/eqoa-frontiers-us-e00-offline-20261028-001.md) register three collected, reviewed fully offline modified-card controls. Runtime hashes/timestamps are populated; exact endpoints and raw bytes remain restricted outside Git. These are completed offline controls, not a completed full E00 or proven guest-only/all-flow capture. E01 is not run, and no protocol fixture or implementation gate is opened.

The later [N01 manifest](manifests/eqoa-frontiers-us-e00-n01-20261029-001.json) and [result](interpretations/eqoa-frontiers-us-e00-n01-20261029-001.md) register one successful guest-address/DNS-path qualification and bounded DNAS-screen observations. Collection was October 28 local time / October 29 UTC. No raw bytes, images or credentials are imported; full E00 repeatability and E01 completion are not implied.

The October 29 [online-host resolver-boundary review](interpretations/e00-online-host-resolver-boundary-20261029.md) records a failed synthetic Windows containment check with both positive controls present. It is not a PS2/client experiment. The two requested online-host cold starts did not begin; raw probe artifacts remain outside Git.

The October 30 [N02 clean-card result](interpretations/eqoa-frontiers-us-e00-n02-20261031-001.md) and [manifest](manifests/eqoa-frontiers-us-e00-n02-20261031-001.json) register the earlier controlled offline collection: six screenshots, stable seed-derived working card, guest IPv4/DNS, an unexpected resolver address and recovery. The in-game network configuration tool ran during capture. This differs from the earlier proposed online-host repetitions and does not close E00/E01.

A later operator-approved five-minute-policy N02 records the corrected DNS destination, eight screenshots and DNAS Error (-611). Its [separate manifest](manifests/eqoa-frontiers-us-e00-n02-20261031-002.json) and [N01/N02 comparison](interpretations/e00-n01-n02-comparison-20261030.md) preserve both this result and the earlier setup control. The run ended by normal operator close before five minutes; DHCP no longer shortened the window. No full E00/E01 or DNAS success is implied.

The October 31 [E01 manifest](manifests/eqoa-frontiers-us-e01-20261031-001.json) and [review](interpretations/eqoa-frontiers-us-e01-20261031-001.md) record one explicitly authorized lab-PNACH experiment following a qualified E00 handoff. Screenshots show DNAS Status: Done and a subsequent update error; raw TAP frames show SYN attempts to `198.18.0.1:7000`, without a reply/application exchange. Nine images, 92 integrity checks and exact rollback were reviewed. Source/candidate patch files, cards, images and raw captures remain outside Git. Full E00/E01/E02 and Protocol Implementation Gate status are not promoted by this scoped result.

A separately approved [TCP/7000 observation](interpretations/eqoa-frontiers-us-e01-tcp7000-20261031-001.md) and [manifest](manifests/eqoa-frontiers-us-e01-tcp7000-20261031-001.json) now establish a completed lab handshake and one 104-byte HTTP/1.1 GET for the update-manifest path. The legacy Host field is distinct from the lab connection destination. No application response was sent. Four images, raw-stream/payload equality, integrity and listener/firewall/profile rollback are reviewed; response acceptance and full E01 remain open. Only sanitized decoded fields and hashes are published.

## Authority and classification

- Raw capture files are the authoritative record of observed bytes and packet/stream boundaries.
- Decoded interpretations are separate, versioned hypotheses. Never overwrite or “correct” raw evidence with a decoded/re-encoded form.
- Use the evidence terms from [../architecture.md](../architecture.md): `CONFIRMED — reference`, `CONFIRMED — client/protocol`, `INFERRED`, `UNKNOWN`, `HISTORICAL CHOICE`, `NIGHTHAVEN DECISION`, and `REJECTED LEGACY BEHAVIOR`.
- The current inventory and experiment sequence are in [../protocol-unknowns.md](../protocol-unknowns.md), [../client-interoperability-plan.md](../client-interoperability-plan.md), and [../protocol-evidence-plan.md](../protocol-evidence-plan.md).

## Suggested evidence layout

```text
docs/evidence/
├── README.md
├── manifests/
│   └── <artifact-id>.json
├── interpretations/
│   └── <artifact-id>.json
└── fixtures/
    └── <fixture-id>/
        ├── manifest.yaml
        └── packets/                 # reviewed, sanitized derivatives only
```

Do not store raw `.pcap`/`.pcapng`, original game images, BIOS files, passwords, or other sensitive data in this Git working tree by default. Keep raw captures in operator-approved access-controlled encrypted storage; reference them by stable artifact ID, restricted location and SHA-256. A reviewer must approve any sanitized derivative before it enters source control.

Current checkpoint manifests and interpretations use JSON. YAML remains acceptable for future records under the same metadata and evidence rules. The fixture layout is illustrative; no fixtures exist yet.

## Required metadata

Use the manifest and decoded-record fields described in [../protocol-evidence-plan.md](../protocol-evidence-plan.md): experiment ID, UTC timestamp, client profile/revision, runtime, tool versions, direction, transport, endpoints, flow/session context, raw hash, packet boundaries, interpretation reference/status, decoder and assumptions, redaction record, and observed client state.

For each sanitized fixture, retain a link to its raw artifact hash, document the transformation and reviewer, and state whether test expectations are byte exact or semantic. If a sensitive field cannot be safely identified/redacted without changing the evidence semantics, keep the artifact restricted and do not publish a fixture yet.

## Redaction and access

Raw evidence may contain credentials, account IDs/names, email/profile values, session tokens, IP/MAC addresses and machine identifiers. Keep it restricted and encrypted. Sanitized copies should use consistent pseudonyms only where correlation is necessary. Never put secret values in paths, logs, commit messages or issue names. Do not destroy the raw capture to make a shareable copy.

## No evidence claim without provenance

Do not label any packet field or client transition `CONFIRMED — client/protocol` without a specific artifact ID, experiment, client profile, raw hash and interpretation record. External revival-project documentation is reference material, not client capture evidence for Nighthaven. Sandstorm endpoints or code are not Nighthaven dependencies.

