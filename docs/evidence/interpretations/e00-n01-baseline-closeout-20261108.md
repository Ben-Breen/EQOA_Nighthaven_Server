# E00-N01 contained baseline closeout

Reviewed 2026-11-08 (America/Chicago). Frontiers US SLUS-20744 / EEEE1FCC, PCSX2 2.8.2.0, unpatched cold boots with the same modified-card source and isolated Nighthaven E00 TAP. See the [client identity manifest](../manifests/eqoa-frontiers-us-static-20261025.json) and [E00 acceptance criteria](../../protocol-evidence-plan.md#e00--client-profile-and-clean-baseline).

| Cold start | Evidence session | TAP frames | DNS frames | Stable screen |
| --- | --- | ---: | ---: | --- |
| [Original N01](eqoa-frontiers-us-e00-n01-20261029-001.md) | `E00-N01-20261029T004029603Z` | 35 | 24 | DNAS Error (-611) |
| [Second N01](e00-n01-repeat-20261108.md) | `E00-N01-20261108T125525316Z` | 39 | 24 | DNAS Error (-611) |
| Third N01 | `E00-N01-20261108T130605766Z` | 40 | 24 | DNAS Error (-611) |

The ISO, emulator, BIOS and sidecars, source card, runner and DNS helper hashes match across the three runs. Effective INI values differ only in the per-session log and screenshot output directories. Earlier offline controls and N02 variants remain separate. The third run started TAP capture at 13:06:40.444 UTC before the emulator launched at 13:06:41.909 UTC. The first DHCP-send log was observed at 13:08:04.975 UTC, the final screenshot was written at 13:09:02.601 UTC, and the runner finished at 13:09:15.945 UTC after normal operator closure.

**CONFIRMED — client/protocol**, scoped to these runs. All three TAP captures contain the same DNS question names, types, destination addresses, response codes and counts. Each contains eight questions from `198.18.0.2` to the lab resolver, eight to a contained non-lab resolver destination, and eight REFUSED replies from the lab resolver. The third capture contains zero guest IPv4 frames outside DNS. Its first retained screenshot shows SCE/Ethernet connecting and its last shows DNAS Error (-611), before account interaction.

**NIGHTHAVEN DECISION.** Mark NH-E00 complete for the named, contained N01 baseline. Three cold starts reproduce the observable startup outcome and DNS destinations, and the TAP captures and emulator logs have been reviewed within their respective boundaries. The logs supplement the raw TAP record for internally handled DHCP. Coverage of every pre-TAP flow, normal online destinations, exact button timing and physical-hardware behavior remains **UNKNOWN**. The DNS reply and the -611 screen establish co-occurrence in this setup. The cause of -611 remains **UNKNOWN**. Preserve the existing capture-coverage qualification and the separate E01 account-login work. Architecture Gate #2 remains PASS, Evidence Acquisition OPEN, and Protocol Implementation CLOSED.

## Third-run integrity and restoration

The authoritative ETLs, pcapng conversions, five screenshots and manifests are indexed by the session ID in the restricted EFS raw store outside Git. Review verified 84 manifest references with zero mismatches, and checked encryption and operator/SYSTEM-only Allow ACLs for all 58 raw session files. PktMon 10.0.19041.3636 captured Ethernet frames on component 1056 and reported no events lost in its stop output. The offline decoder was `inspect_e00_capture.py`, SHA-256 `0ab07d03f7913847f9303a37d0fd73d12d9d4bba9d0c28dbe6c0f22e7cfc859e`. Packet bytes remain authoritative. DNS names and the non-lab address are omitted from this review.

| Restricted artifact | SHA-256 |
| --- | --- |
| Session manifest | `5180203d0bdd33ab8294f9455582cfd452a18cc43278be015e6599a007f58841` |
| Run manifest | `781ea459639662163734d0a360e8de194db2ccf2704b494ebed9726a57f94b89` |
| `capture1.etl` | `985b8108be1f8d613d4f37d0bdf4681fa0d70c20fbbcabf151c1d80c8f369d6f` |
| `capture2.etl` | `7ada4108c1795599a7b8ba68fbf588d8acbad4b4f5dab300b9d5345d262dc49f` |
| Final screenshot | `dd20bbea9fb50af668a543f63318a422e38b11d6d031203a17b03b9d5c6241be` |

Post-run checks found PCSX2 closed, the fail-closed INI hash restored, the DNS service stopped and the physical adapters back in their prior administrative states. The already-enabled lab TAP stayed enabled.
