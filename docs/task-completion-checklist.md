# Nighthaven Codex — Task Completion Checklist

**Reviewed:** 2026-10-26 (America/Chicago)  
**Repository:** [Ben-Breen/EQOA_Nighthaven_Server](https://github.com/Ben-Breen/EQOA_Nighthaven_Server)  
**Last verified repository commit:** [`d63bea28b198620bc2a1dfa44ae3640dfb84a5e6`](https://github.com/Ben-Breen/EQOA_Nighthaven_Server/commit/d63bea28b198620bc2a1dfa44ae3640dfb84a5e6), 2026-10-25  
**Intended repository path:** `docs/task-completion-checklist.md`  
**Phase:** Architecture, reference archaeology, and independent client/protocol evidence research. Wire-facing implementation is **not authorized** by this checklist.

## Status and evidence rules

- **COMPLETE**: Named deliverable exists in the committed repository or another inspected and verifiable artifact satisfies its acceptance criteria. A documentation task being complete does **not** imply the research experiment it specifies has been executed.
- **IN PROGRESS**: Specific observed work exists, but acceptance is not yet satisfied.
- **BLOCKED**: A prerequisite has not yet been verified.
- **NOT VERIFIED**: Current accessible evidence does not establish completion; local Codex work may be newer than GitHub.
- Never mark a capture, test, implementation, or interoperability feature complete solely from a Codex assertion or a reference implementation code path.

## Verified complete — research and documentation deliverables

- [x] **NH-DOC-001 — Initialize independent repository and documentation scaffold.** `README.md`, initializer, `.gitignore`, `LICENSE`, initial `docs/`. Verified: [initial commit `cb412f69`](https://github.com/Ben-Breen/EQOA_Nighthaven_Server/commit/cb412f69d3b3e36905daf47a2d6d1332296993b4).
- [x] **NH-DOC-002 — Survey reference server and classify visible features/dependencies.** `docs/reference-implementation-analysis.md`, `docs/functional-matrix.md`, `docs/dependencies.md`, `docs/database.md`, `docs/known-limitations.md`. Verified from initial commit and current documentation. Applies to the *archived reference*, not guaranteed original-client requirements.
- [x] **NH-DOC-003 — Establish source-derived protocol catalog and open-question records.** `docs/protocol.md`, `docs/protocol-message-catalog.md`, `docs/open-questions.md`. Verified from initial commit. Uncaptured field semantics remain unknown.
- [x] **NH-DOC-004 — Commit independent architecture specification.** `docs/architecture.md`: proposed modular monolith, protocol boundaries, PostgreSQL selection, validation/security, session/capacity behavior, tests and recovery. Verified by [commit `79c69efe`](https://github.com/Ben-Breen/EQOA_Nighthaven_Server/commit/79c69efe0c3b7979977ba2285745cc2819aaab2e). This is an architectural specification, not an implemented server.
- [x] **NH-DOC-005 — Prepare evidence acquisition, bootstrap/DNAS and client interoperability research plans.** `docs/protocol-evidence-plan.md`, `docs/client-interoperability-plan.md`, `docs/protocol-unknowns.md`, `docs/evidence/README.md`. Verified by [commit `076a34fc`](https://github.com/Ben-Breen/EQOA_Nighthaven_Server/commit/076a34fcd20ca4ab417b1a3d691414347a18cb67). No experiment completion is implied.
- [x] **NH-DOC-006 — Reconcile architecture and protocol evidence terminology.** Verified by [commit `87e0bc14`](https://github.com/Ben-Breen/EQOA_Nighthaven_Server/commit/87e0bc1470b108dce3ea9c00c88f08ddab65171d) and [commit `d63bea28`](https://github.com/Ben-Breen/EQOA_Nighthaven_Server/commit/d63bea28b198620bc2a1dfa44ae3640dfb84a5e6).

## Experiments — not yet verified complete

These statuses describe *observability in the repository*, not claims that nothing has occurred on the operator's PC.

- [ ] **NH-E00 — Define Frontiers client profile and capture clean baseline.** **IN PROGRESS locally; NOT COMPLETE.** [Pass #5](pass5-status.md) records candidate media fingerprints, a static interpretation ledger, one offline readiness observation and historical TAP setup metadata. These records are supporting evidence, not the required captured baseline. Record legally held client media/build, SHA-256 of operator's own image, emulator/BIOS/network settings, UTC run timeline, and at least three comparable cold-start runs with packet-capture hashes. **Next when complete:** E01.
- [ ] **NH-E01 — Establish DNS/bootstrap/DNAS stage timeline.** **BLOCKED until E00 evidence verified.** Observe DNS, endpoints, transports, HTTP metadata if present, progression/error screens, and one-variable-at-a-time experiments. **Next:** E02.
- [ ] **NH-E02 — Isolate DNAS dependency and alternative client behavior.** **BLOCKED by E01.** Distinguish observed client-side gate, endpoint redirection, patch/account dependencies, and service-side behavior; do not presuppose a bypass or service implementation. **Next:** document decision and E03.
- [ ] **NH-E03 — Determine server discovery and endpoint selection.** **BLOCKED by bootstrap evidence.** **Next:** E04/E05 as applicable.
- [ ] **NH-E04 — Capture account transport and authentication exchange.** **BLOCKED by E03.** Restricted test identities and redacted artifacts required. **Next:** E05.
- [ ] **NH-E05 — Capture first game datagram and session establishment.** **BLOCKED by earlier client flow.** **Next:** E06.
- [ ] **NH-E06 — Verify framing, byte order, sizes, checksums/integrity.** **BLOCKED by E05 captures.** **Next:** E07.
- [ ] **NH-E07 — Verify acknowledgments, retries and login-subset sequencing.** **BLOCKED by E05/E06.** **Next:** E08.
- [ ] **NH-E08 — Capture character list, creation and selection.** **BLOCKED by prior client flow.** Verify minimal creation, the created character appearing in the list, and selection; a provisioned character alone does not satisfy creation. **Next:** E09.
- [ ] **NH-E09 — Capture world entry and player entity initialization.** **BLOCKED by E08.** **Next:** E10.
- [ ] **NH-E10 — Capture minimal movement and replication.** **BLOCKED by E09.** **Next:** E11.
- [ ] **NH-E11 — Capture logout, disconnect, reconnect, and state-recovery behavior.** **BLOCKED by a functioning observed session.** **Next:** evaluate implementation acceptance gates.

## Independent implementation — explicitly deferred

- [ ] **NH-IMPL-001 — Implement .NET server host and separated transport/protocol/domain boundaries.** **NOT STARTED / NOT AUTHORIZED.** Design docs do not constitute implementation permission.
- [ ] **NH-IMPL-002 — Implement capture-backed codecs, bounded parsing and replay tests.** **NOT STARTED / BLOCKED** on protocol evidence and authorization.
- [ ] **NH-IMPL-003 — Implement private PostgreSQL persistence and validated character/session vertical slice.** **NOT STARTED / BLOCKED** on protocol evidence and authorization.

## Daily review procedure

1. Read `main` HEAD and any new commits/issues/PRs in `Ben-Breen/EQOA_Nighthaven_Server`. Inspect this checklist, `docs/roadmap.md`, `docs/protocol-evidence-plan.md`, and any new evidence manifests.
2. Compare observable changes with the previous review. For each new verified completion, report task ID, exact deliverable, commit/file/run ID, acceptance evidence, limitations, and the **next dependency-unlocking task**.
3. Mark `[x]` only when the named deliverable's acceptance criteria are verified. If local Codex-only state cannot be inspected, label it **NOT VERIFIED**, not complete.
4. Produce one or two copy-ready Codex prompts tied to the highest-priority unblocked work.
5. Preserve `EQOAGameServer` as **READ-ONLY**, avoid changes to `EQOA_Nighthaven_Client`, and keep raw captures, client images/BIOS, credentials and proprietary assets out of the Git repository. No service/protocol behavior is to be invented from the historical implementation.
6. If repository update permission is absent, produce a fully revised Markdown file or patch, explicitly report that no GitHub commit was created, and use the next review to reconcile any intervening commits.

## Review history

| Date (America/Chicago) | Observed repository head | New verified complete tasks | Priority |
|---|---|---|---|
| 2026-10-26 | `d63bea28` | Baseline: six existing documentation deliverables `NH-DOC-001`–`NH-DOC-006` identified from commits dated 2026-10-25. No E00–E11 run verified. | E00 evidence audit and baseline |

## Copy-ready Codex prompt: E00 evidence audit

```text
Open EQOA_Nighthaven_Server/docs/protocol-evidence-plan.md,
docs/client-interoperability-plan.md, docs/evidence/README.md,
and docs/task-completion-checklist.md (if present).

Review the E00 acceptance criteria for the original Frontiers PS2 client in a
controlled PCSX2 lab. Inspect existing evidence artifacts and identify whether
an exact client profile, SHA-256 media hash, emulator/network manifest, three
repeated cold-start runs, capture hashes, UTC timelines, and visible-screen
milestones exist. Report each item as VERIFIED, MISSING, or UNOBSERVABLE with
artifact path and evidence; do not assume the operator has done an experiment.

Produce a precise E00 operator runbook and a nonsecret evidence-manifest template.
Do not implement the server, edit the read-only EQOAGameServer reference, alter
EQOA_Nighthaven_Client, copy proprietary assets, publish raw captures, or invent
DNAS endpoints, ports, payloads, or client behavior. If E00 evidence is not
sufficient, leave E00 incomplete and identify the next smallest safe action.
End with an acceptance checklist, suggested verification, and rollback steps.
```
