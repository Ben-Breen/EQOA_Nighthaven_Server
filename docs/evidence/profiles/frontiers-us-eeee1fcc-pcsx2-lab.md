# Candidate profile: Frontiers US / EEEE1FCC / isolated PCSX2

Status: E00 PARTIAL, runtime baseline not complete. Source set: [static manifest](../manifests/eqoa-frontiers-us-static-20261025.json).

| Field | Recorded value / outstanding work |
|---|---|
| Candidate client | Frontiers US; boot file SLUS_207.44; SYSTEM.CNF VER 1.02, NTSC; ELF checksum EEEE1FCC. This identifies supplied media; first supported-client policy is not selected by this record. |
| ISO and executable identity | SHA-256 and sizes in static manifest. Media acquisition/rip history remains operator provenance to record. |
| Emulator | Local executable metadata reports PCSX2 2.8.2.0; exact executable SHA-256 is in the P00 observation manifest. Package acquisition provenance remains operator context. |
| Platform | Windows host; exact OS build and network/capture topology to record before a run. |
| BIOS | Copied BIOS log identifies USA v01.60 (07/02/2002); its hash is in the P00 observation manifest. Operator acquisition provenance is pending. BIOS and writable sidecars are separate lab copies; never commit their bytes. |
| Setup selection | Operator chose isolated copy of settings and card on 2026-10-25; source ISO retained unchanged. |
| Card variants | Supplied card is modified, not pristine. Name copied-card baseline separately from an independently created blank/clean-card control. Hash each initial snapshot and each post-run result. |
| Patch variants | Record loaded/disabled groups, built-in compatibility patches, external cheat/patch file hashes, game settings and savestate state. File presence is not proof of activation. |
| Network | Existing source config uses DEV9 Sockets backend. A dedicated TAP adapter setup is recorded in the [lab setup manifest](../manifests/eqoa-frontiers-us-tap-lab-20261025.json); it does not establish guest backend selection or packet visibility. Lab routing, DNS, captures, adapter/MAC treatment, endpoint containment, and outbound policy must be reverified before each run. Copying emulator settings is filesystem isolation, not network isolation. |
| Captures | None collected by the static checkpoint. Capture tool/version, UTC/monotonic timing, restricted encrypted storage and hashes pending. |
| Test actions | No login/credentials for first baseline. No save-state resume. Cold-start phase and first stable screen must be defined consistently. |

Runtime result fields remain unfilled until observed. A setup/preflight success is not a captured cold-start result, and three identical offline failures do not establish an online service sequence. Record a blocked-network profile as such rather than generalizing it to the normal network path.

[P00 offline readiness observation](../manifests/eqoa-frontiers-us-p00-offline-20261025-001.json) records the first operator-driven boot in the isolated setup. It does not complete E00 or establish network behavior.
