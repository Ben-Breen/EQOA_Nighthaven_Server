# E00 online-host containment qualification — failed boundary

Reviewed 2026-10-29 (America/Chicago). Artifact ID: `DNS-Attribution-20261029T053444148Z`. This is a **synthetic Windows host-resolver test**, not a PS2/client experiment. Neither requested online-host cold start (N02/N03) began. Full E00 remains incomplete; E01 remains not run as a dedicated experiment.

## Question and method

Can a per-executable outbound firewall block contain the Windows name-resolution path while the laptop remains online? The earlier [TAP source finding](../experiments/E00-N01-contained-startup.md#capture-boundary) identifies a possible host-resolver path separate from raw guest TAP forwarding.

An independently written native probe called `GetAddrInfoExW` with `NS_ALL`, using a different fresh synthetic absolute name for each phase. Temporary exact-name NRPT rules directed those names only to three unresponsive, on-link TAP peers. PktMon captured TAP component 1 with a UDP/53 lab-subnet filter. No guest, DNS responder, game endpoint or external test destination was started/contacted by the probe procedure. Normal host DNS settings and physical adapter states were unchanged.

The middle phase applied an active, per-probe-executable outbound Block rule for all profiles, protocols and remote addresses. Both surrounding phases omitted that rule. This used an elevated operator token and a synchronous resolver call; it does not reproduce the intended medium-token PCSX2 process or all of its resolver options.

## Observations and interpretation

| Phase | UTC interval, 2026-10-29 | Synthetic TAP destination | Captured matching A queries |
|---|---|---|---|
| Positive control before | 05:34:47.2157063–05:34:59.4316248 | `198.18.0.242:53` | 5 |
| Executable firewall-blocked | 05:35:01.9854890–05:35:14.0842967 | `198.18.0.243:53` | 5 |
| Positive control after | 05:35:16.5717966–05:35:28.6755043 | `198.18.0.244:53` | 5 |

These are direct host-runtime observations, **not `CONFIRMED — client/protocol` facts**. An offline PowerShell review read pcapng enhanced-packet blocks, Ethernet/IPv4/UDP headers and uncompressed DNS question labels, correlating each full question name against the retained phase timeline. The table omits random name suffixes. Raw bytes remain authoritative; this limited decoder is not a production protocol parser or fixture framework.

**INFERRED:** the proposed executable-only rule is insufficient for this resolver path. Windows DNS brokerage is a plausible explanation, consistent with the earlier source concern; packet capture alone does not establish the sending process identity. Both positive controls are present, so the blocked-phase observations cannot be dismissed as an all-zero or missing-control result. The test demonstrates a local containment counterexample, not delivery to an external resolver or proof that this exact call occurred during a PS2 run.

**UNKNOWN:** containment for the actual medium-token PCSX2 process under a stronger boundary; complete attribution of brokered requests; comparability of future host-online repetitions with the physically disconnected N01 baseline. This probe does not answer DNAS behavior, guest DNS-selection origin or original-hardware behavior.

**NIGHTHAVEN DECISION:** do not start N02/N03 with the laptop online under the failed executable-only boundary. A stronger isolation boundary must first demonstrate the intended allowed lab path and blocked off-lab paths, including host-brokered resolution. A separately isolated VM/network environment is a candidate to evaluate, not an installed dependency or a new architecture decision. Do not silently substitute the earlier host-offline procedure for the requested online-host runs.

## Provenance, retention and cleanup

Raw files remain in the existing operator-only EFS raw store under the artifact ID above, outside Git. No raw packet bytes, executable/source probe files, account values, machine identifiers or game content are included here. Operator-provided PCSX2/client inputs were not used by this synthetic probe. Interpretation: Codex, offline packet-name/count review on 2026-10-29; assumptions and scope are stated above. This is a sanitized description, not a modified raw capture or replay fixture.

| Retained local artifact | SHA-256 |
|---|---|
| `probe1.pcapng` | `a4f11a97b87d1165aec8e78650ef3efec0c2e29310ff6dce5d1a90ce259a5893` |
| `result.json` | `e455163cf126364ead768c8d3915f7ba6195fd280d5e692a9da8fe1f34959efe` |
| Executed `E00-OnlineResolverProbe.ps1` | `92a30257b303362940be06f09e944f8215117b0914b10f26f0a7fcc0596cd2ed` |

The result records cleanup complete with no cleanup errors. Subsequent read-only checks found Wi-Fi Up; PCSX2 and probe processes absent; `EthEnable=false`, `EthApi=TAP`; the original DNS service still Stopped; and zero owned firewall rules, NRPT rules or permanent synthetic neighbor entries. Transient Unreachable neighbor-cache records are not persistent configured peers. The helper reports no physical-interface or service changes. No BitLocker change was made, and no commit or push was performed.

Next measurable action: qualify a stronger online-host boundary with visible allowed-path controls and zero forbidden-path packets under the intended runtime conditions **before** either guest cold start. This note does not authorize installing a VM, changing global DNS or relaxing containment.
