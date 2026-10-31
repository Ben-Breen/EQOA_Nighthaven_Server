# E01-U02 — independent Nighthaven updater progression

Reviewed 2026-10-31. **COMPLETE for one bounded implementation/observation; account login NOT confirmed.** [Manifest](../manifests/eqoa-frontiers-us-e01-u02-20261031-001.json) and [run card](../experiments/E01-U02-bootstrap-response.md) register session `E01-U02-20261031T193950239Z`. Broad server functionality remains gated; the explicit authorization covered only this disposable bootstrap probe and one isolated test.

## What was implemented

The independently authored [responder](../../../tools/ProtocolEvidenceLab/E01BootstrapResponder.ps1) returns a fixed gzip/XML manifest and separate original Changes text, bound only to the lab and permitted guest. It contains no File/download/deletion entries, Sandstorm content, external endpoints or game assets. Its request allowlist, four-connection/time/byte limits, evidence storage and HTTP response identities are explicit. [Offline checks](../../../tools/ProtocolEvidenceLab/Test-E01BootstrapResponder.ps1) pass19 cases; the private capture harness separately passes110 isolation/recovery regressions. This is a disposable PowerShell evidence tool, not an architectural choice for the C#/.NET server. The standalone general-purpose content generator remains deferred.

The external capture established version identifiers1/36, Changes version0/port7000 and a Changes CRC matching standard CRC32 in decimal. We retained the version identifiers as scoped compatibility hypotheses, replaced the distribution label/endpoints and authored new Changes text. Field necessity, version policy and minimal no-update schema remain UNKNOWN. No original-client parser success branch was conclusively established by the bounded static string searches; opaque AUT modules remain a research limit.

## Observed result

**CONFIRMED — client/protocol**, scoped to this modified Frontiers US EEEE1FCC / PCSX2 2.8.2.0 session:

- Three TCP/7000 connections delivered one307-byte manifest HTTP response and two118-byte Changes HTTP responses. The requests total220 bytes; responses total543 bytes. All six payloads match the listener artifacts; all response bytes and FINs are acknowledged. There were47 captured frames, including30 TCP frames. No subsequent account-service connection appears in this capture; guest UDP observations are DNS only. TAP/interception blind spots remain explicit.
- Eight reviewed images show the EQOA2 profile, Connecting, Connected, Initializing Network, DNAS Done twice, **Writing game data**, then a **black screen**. A login form is not visible in these images. The operator reported that it “sort of reached account login” and guessed a missing authentication server; that guess is not established by the captured traffic.
- The log shows updater-era memory-card saving followed by audio/network-configuration module teardown and display/controller reinitialization. It does not identify the black-screen cause or demonstrate account authentication. The guest closed normally; no second variant was attempted.

**INFERRED:** this candidate advances beyond the prior empty-response error into writing game data and a later client transition. This is useful interoperability progress, not a finished login path or proof of a minimum manifest.

**UNKNOWN:** whether the next blocker is program/resource selection from disc versus card, missing/cached client resources, selected version/empty-file-list assumptions, remaining loader/decryption compatibility, rendering, or a service dependency not visible at this capture boundary. A limited raw card name/page scan did not validate allocation or execution and resolves none of those hypotheses. Do not fetch/copy Sandstorm resources or implement a speculative authentication service to hide the unknown.

## Integrity and restoration

All112 recorded references verify:71 session,34 embedded run and seven inputs. All72 session files plus three authorization/observer files remain EFS encrypted with operator/SYSTEM-only access outside Git. The public responder fingerprint matches the exact run helper. Original ISO, prepared source card and supplied original patches are preserved; ordinary writes affect only the disposable working card. Candidate PNACH bytes are unchanged.

A separate elevated read-only check at19:46:05Z verifies exact original-profile rollback with networking/cheats disabled, no capture/listener/helper/temporary rule, DNS restored stopped and saved physical administrative adapter states restored. No extra unpatched boot occurred. Raw captures, screenshots, cards, BIOS, original patch code and external response content are not published. Only independently authored tool code and sanitized evidence are included.

## Next measurable action

Identify the program/resource selected immediately after updater teardown, its source (disc or card) and the first failed or unresolved load/transition. Completion evidence: original-media function/offset references or focused runtime file-open/loader evidence sufficient to distinguish client loading from a service wait. Use existing artifacts first; any new live run needs separate explicit approval. Do not claim successful account login until a visible login state and its relevant transition evidence are recorded.

Architecture Gate #2 **PASS carried forward**; Evidence Acquisition Gate **OPEN**; E00/E01 **PARTIAL**; Protocol Implementation Gate **CLOSED** for broad server/account/game functionality. The narrow disposable bootstrap-probe authorization does not open those gates.
