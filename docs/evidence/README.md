# Protocol evidence workspace

This directory is for Nighthaven protocol evidence manifests, sanitized interpretations and reviewed fixtures when collection begins. **No packet captures, client images, game assets or protocol fixtures were created by the research-planning pass.**

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
│   └── <artifact-id>.yaml
├── interpretations/
│   └── <artifact-id>.yaml
└── fixtures/
    └── <fixture-id>/
        ├── manifest.yaml
        └── packets/                 # reviewed, sanitized derivatives only
```

Do not store raw `.pcap`/`.pcapng`, original game images, BIOS files, passwords, or other sensitive data in this Git working tree by default. Keep raw captures in operator-approved access-controlled encrypted storage; reference them by stable artifact ID, restricted location and SHA-256. A reviewer must approve any sanitized derivative before it enters source control.

## Required metadata

Use the manifest and decoded-record fields described in [../protocol-evidence-plan.md](../protocol-evidence-plan.md): experiment ID, UTC timestamp, client profile/revision, runtime, tool versions, direction, transport, endpoints, flow/session context, raw hash, packet boundaries, interpretation reference/status, decoder and assumptions, redaction record, and observed client state.

For each sanitized fixture, retain a link to its raw artifact hash, document the transformation and reviewer, and state whether test expectations are byte exact or semantic. If a sensitive field cannot be safely identified/redacted without changing the evidence semantics, keep the artifact restricted and do not publish a fixture yet.

## Redaction and access

Raw evidence may contain credentials, account IDs/names, email/profile values, session tokens, IP/MAC addresses and machine identifiers. Keep it restricted and encrypted. Sanitized copies should use consistent pseudonyms only where correlation is necessary. Never put secret values in paths, logs, commit messages or issue names. Do not destroy the raw capture to make a shareable copy.

## No evidence claim without provenance

Do not label any packet field or client transition `CONFIRMED — client/protocol` without a specific artifact ID, experiment, client profile, raw hash and interpretation record. External revival-project documentation is reference material, not client capture evidence for Nighthaven. Sandstorm endpoints or code are not Nighthaven dependencies.

