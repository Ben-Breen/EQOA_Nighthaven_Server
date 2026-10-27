# Client interoperability research plan

This plan sequences client and bootstrap questions that must be answered before Nighthaven implements a wire-facing path. It is research planning only. No client or server code is modified by this document.

## Research tree

```text
Client compatibility research
├── Client profile and test environment
│   ├── Which disc/build/revision is the first target?
│   └── Does behavior differ on physical PS2 versus PCSX2?
├── Bootstrap
│   ├── What is the startup network sequence?
│   ├── Which DNS queries and responses occur?
│   ├── Is HTTP/patch/MOTD required, and at what stage?
│   └── How are server endpoints selected/configured?
├── DNAS
│   ├── When does the check run and what initiates it?
│   ├── Which endpoint/service and request/response are involved?
│   ├── What result gates client progression?
│   ├── Does behavior differ by client revision or emulator?
│   └── Does Nighthaven need a client-side change, endpoint redirection,
│       a response emulator, replacement service, or none of these?
├── Account service
│   ├── Does the client open TCP account transport, game transport, or both?
│   ├── What are request framing, authentication and response behavior?
│   └── How are account identity and game session correlated?
├── Server discovery
│   ├── Is discovery DNS/config/HTTP/protocol list or a combination?
│   └── Which address/port/endpoint identifiers are selected?
├── Game transport and session
│   ├── What is the first game datagram and initial state transition?
│   ├── How do client/server establish and acknowledge a session?
│   └── What are framing, integrity, sequence and retry semantics?
├── Character list
│   ├── What request/response sequence reaches the list?
│   └── Which fields/limits make a valid empty or one-character list?
├── Character selection
│   ├── What payload selects a character?
│   └── Which response/event advances to world entry?
├── World entry
│   ├── Which messages establish zone and initial world state?
│   └── What client-ready/enable transition is observed?
├── Entity initialization
│   ├── What creates a visible local/player entity?
│   └── How are server and client entity IDs correlated?
├── Movement
│   ├── What client update is sent by controlled movement?
│   └── What server replication makes one avatar visibly move?
└── Disconnect / reconnect / persistence
    ├── What normal logout and abrupt loss look like?
    ├── Does the client resume a prior player session after reconnect?
    └── Which state survives logout, transient loss, or process restart?
```

## Current acquisition checkpoint

[Pass #5 status](pass5-status.md) links the candidate Frontiers profile, hashed static artifact manifest, interpretation ledger, and isolated E00/E01 run card. The inspected patch modifies a shared resolver, named DNAS routines, a resource pathname, and a local patch-loading hook. This is evidence about that supplied compatibility method; it selects no Nighthaven compatibility mechanism. The supplied card is already modified. No capture-backed startup result or original-hardware result is asserted.

## Client profile and environment record

Before collecting protocol evidence, identify a specific target client: region, game edition, disc/build identifier and cryptographic hash of the user's own disc image (record the hash and media provenance, not the image in the Nighthaven repository). Record PS2 model/network path or emulator version, BIOS provenance, network plugin/settings, memory-card/network configuration, and whether any client patch/cheat is active. Do not change the Nighthaven client repository as part of this research.

Treat each combination of client revision and runtime path as a separate profile until evidence justifies merging them. The reference's Vanilla/Frontiers enum values are `CONFIRMED — reference`; they do not establish target coverage.

## Bootstrap and endpoint experiments

Use isolated test networking and passive capture first. Record DNS, TCP, UDP and HTTP metadata from cold boot through first game-server attempt. Then vary exactly one condition per run: default DNS versus controlled DNS, patch endpoint reachable versus unreachable, account service reachable versus unreachable, or game endpoint reachable versus unreachable. Preserve a successful baseline capture before perturbing anything.

The results should answer whether Nighthaven needs each endpoint/service, not reproduce a revival project's topology. A client-discovery mechanism may be DNS, HTTP, a game-server-list message, stored configuration, or multiple stages; all remain `UNKNOWN` until observed.

## DNAS research track

### Current classification

- **UNKNOWN:** exact DNAS request/response, endpoint, timing, initiator, result-gate, variant behavior, and Nighthaven requirement.
- **Project premise:** the original client includes a DNAS-related check/service dependency associated with historical SOE infrastructure. This is a research starting point, not a complete wire fact.
- **External documentation reports (Sandstorm only):** Sandstorm's install guide states that its game patch replaces the DNAS check, offers a patched-ISO path and a PCSX2 `.pnach` alternative, and states its current patch no longer relies on DNS to find its server. Sandstorm's history says that after its DNAS bypass the client contacted a patch server, then patch/login services enabled progression to UDP game traffic. These are claims about Sandstorm's reported setup, not `CONFIRMED — reference` evidence from the surveyed repository or `CONFIRMED — client/protocol` evidence for Nighthaven. They do not prove Nighthaven needs those exact changes or that a server-side DNAS service exists/is needed. References: [Sandstorm Install & Connect](https://eqoa.live/install.html), [Sandstorm project history](https://eqoa.live/story.html).
- **HISTORICAL CHOICE:** Sandstorm's patch/endpoint design is its own solution. It is research material only. Nighthaven must use endpoints and configuration controlled by Nighthaven, and must not copy closed-source implementation or depend on Sandstorm infrastructure.

### Questions to resolve

1. At what exact boot stage does DNAS-related activity occur, and what client component initiates it?
2. What name/address/transport is contacted? Is there DNS lookup, a hard-coded target, or a stored/configured endpoint?
3. What request metadata and response are exchanged? What observable success/failure value permits or blocks later execution?
4. Does this behavior vary across the Vanilla/Frontiers, regional, or other target revisions, or between original PS2 and PCSX2?
5. Is DNAS distinct from server discovery, patch/MOTD, account login, and game UDP, or are some steps coupled by the client?
6. Which behavior does the Sandstorm client patch change: only the DNAS result gate, endpoint redirection, patch/update behavior, or additional code? What can be learned from public documentation and controlled observation without copying its patch/code?
7. Can the Nighthaven target operate with no DNAS-specific server when client-side compatibility is handled, or does it require a Nighthaven-operated compatible response/service?

### Evidence required before an implementation decision

- A cold-start capture with exact client revision/runtime and network configuration, showing request timing and destination metadata from before DNAS through the next stage.
- Repeated baseline runs plus isolated reachability perturbations: DNAS-related endpoint unavailable/available where observable, DNS behavior changed in a controlled lab, and later patch/account/game endpoints independently available/unavailable.
- A client-side progression result for each run (error screen, retry, patch request, login screen, server list, or other observable state), tied to the capture. Do not guess the meaning of a failure code.
- A comparison of an unmodified client path and an independently documented revival compatibility path, noting exactly which changes are evidenced. Use the revival method only as an experimental comparison; do not distribute or import the patch.
- Original PS2 confirmation for any behavior that will be required of physical hardware; emulator-only results remain labeled `INFERRED` for hardware compatibility.
- A written conclusion selecting one of: no DNAS-specific Nighthaven behavior; version-specific client-side compatibility requirement; Nighthaven-owned endpoint redirection; Nighthaven-owned response emulator/replacement service; or a justified combination. Each choice needs capture-backed evidence and explicit endpoint ownership/configuration.

Until this evidence exists, no DNAS bypass mechanism, endpoint, port, packet, or service behavior is specified.

## Evidence comparison model

For each transition, keep three observations separate:

| View | What it answers | What it cannot prove alone |
|---|---|---|
| Client capture/behavior | What this client emits, accepts, and visibly does in a specific run | That every client revision behaves the same |
| Reference implementation | What the old server expects/sends/does | That those choices are required by the client |
| Controlled differential | Whether changing one condition affects client progression | Why the change matters unless the wire/state result is observed |

Record discrepancies rather than editing captures or treating the reference response as the expected protocol.

## Research handoff

The ordered experiment queue, evidence file format, fixture plan and wire implementation gates are in [protocol-evidence-plan.md](protocol-evidence-plan.md). The row-level current status is in [protocol-unknowns.md](protocol-unknowns.md).

