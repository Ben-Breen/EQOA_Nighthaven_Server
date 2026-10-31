# E01-U02 — Nighthaven bootstrap response

Prepared 2026-10-31. **COMPLETE for one approved bounded observation; login goal NOT achieved.** The [result](../interpretations/eqoa-frontiers-us-e01-u02-20261031-001.md) and [manifest](../manifests/eqoa-frontiers-us-e01-u02-20261031-001.json) record delivery, Writing game data, then black screen. Implements a disposable lab responder only; no account/game/database implementation or standalone content-generator tool. Broad Protocol Implementation Gate remains CLOSED.

## Evidence and candidate

The [external reference](../interpretations/eqoa-frontiers-us-e01-reference-20261031-001.md) supplies scoped evidence of HTTP200/gzip XML followed by separate Changes.txt exchanges. Its initial request matches the lab request. Subsequent technical inspection found manifest version identifiers1/36, Changes version0, port7000, and a Changes CRC matching standard CRC32 in decimal. These are reference observations; necessity, minimum field set and original-client generality remain UNKNOWN. Static searches of the original bootstrap/REL did not establish the updater parser's success/failure branches; no claim of complete parser reverse engineering is made.

The independent candidate retains observed tag/attribute syntax, uses a Nighthaven distribution label, contains **zero File/download/deletion entries**, and embeds only `198.18.0.1:7000` with the observed Changes path. Its Changes response contains independently authored laboratory text; no reference text/manifest values for files/assets/endpoints are replayed. Version choices and empty-distribution acceptance remain hypotheses. Gzip serialization is part of this fixed responder; the proposed general-purpose generator remains deferred.

| Candidate response | Total HTTP bytes | SHA-256 |
|---|---:|---|
| Nighthaven-empty-distribution-v1 |307|`fc3dd9c20882f8d74e99d622ae83d37f37da89f7da03b1eae184a0b9f79efd05`|
| Nighthaven-changes-v1 |118|`1b13bd2e084f64910817bdb7bcab9e0dc40ffbf7e1fd664b69ba4857fc03ec07`|

The local v4 package and launcher pin the independently authored helper and both responses.110 synthetic harness checks and19 response/loopback checks passed, including standard CRC vector, deterministic gzip/HTTP identities, decoded XML/no File nodes, endpoint/checksum agreement, exact request allowlist and EOF framing. Offline tests do not establish client acceptance.

## Run scope and acceptance

Use the unchanged guarded Nighthaven PNACH and the same prepared N02 card source copied to a disposable working card. Preserve all earlier E01 bundles/results; v4 has distinct U02 status/recovery paths and checks prior restoration. No existing profile changes occur during authoring. The approved run temporarily disconnects physical uplinks, uses the owned TAP capture/DNS-Deny boundary, and restores the original profile with networking/cheats off before restoring uplinks.

Capture precedes listener/guest. Only lab `198.18.0.1:7000` binds; only guest `198.18.0.2` is accepted. At most four sequential connections in300seconds; each request is bounded to64KiB/20seconds/3seconds idle. The first request must exactly match the captured updater GET; later requests must match one of the two approved GET/Host shapes. Unknown methods, paths, queries, headers or credentials receive no response and end the observation. Responses include explicit Content-Length, Content-Type and Connection close. Request/response bytes and write/closure metadata stay in restricted EFS storage outside Git.

Operator: EULA → Play → saved EQOA2 profile. Stop at account login or the first error before credentials; normal close or300seconds maximum. No automatic second variant, retry experiment or unpatched boot. Preserve raw evidence even on failure. Verify owned listener/rule/capture cleanup, exact original INI, DNS/adapters and source preservation.

Transport delivery/catalog checks are separate from visible client acceptance. Success requires reviewed packet evidence and progression to account login; mark a screen as operator-reported if no image is available. A failure narrows only this candidate in this environment, not every no-update manifest. Record unresolved field/endpoint/client-state dependencies and keep E01 PARTIAL until its wider acceptance criteria are met.

## Reviewed outcome

One manifest and two Changes responses were captured and acknowledged; the client advanced to Writing game data and then a black screen. Eight screenshots,112 matching file references and independent elevated rollback verification are registered. Account login is not confirmed, and no subsequent account-service connection was captured. Missing authentication service is an unproven hypothesis, not a reason to add a speculative handler. No second variant was run. The next task is identifying the post-update client loading/transition failure.
