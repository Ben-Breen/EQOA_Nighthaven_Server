# E00 first baseline and E01 handoff

Status: PREPARED / NOT RUN. Candidate profile: [Frontiers US isolated PCSX2](../profiles/frontiers-us-eeee1fcc-pcsx2-lab.md). Follow the existing [E00–E11 plan](../../protocol-evidence-plan.md); this card does not reorder or close its gates.

## Setup and preflight

1. Use a separate local emulator data directory/runtime copy with its own settings, logs, screenshots, caches and memory-card files. Keep originals unchanged and outside the Nighthaven Git tree. Record source/copy hashes.
2. Preserve the supplied modified card snapshot as evidence; label its clone explicitly. A clean control must use a separately identified card/settings profile. Never call a cheats-disabled modified card pristine.
3. Verify which mc0 card is actually mounted, selected BIOS, emulator build/hash, game settings, patch enablement and cold-boot mode. Capture relevant configuration hashes without publishing secret or identifying values.
4. Verify guest-only capture where available, coverage limitations of the Sockets backend, UTC clock, packet link type, capture format/tool version, restricted encrypted raw storage and available disk space. Do not start host-wide collection by default.
5. Establish a controlled network route before enabling guest traffic. The selected cloned setup is not itself network containment. No Sandstorm endpoint is a Nighthaven service, and no public server traffic or account interaction is required by this first run card. A blocked-outbound preflight must be labeled separately from an online baseline.
6. Record whether patches are enabled, including any built-in compatibility fixes. Do not combine IP, card configuration, DNAS code, DNS and networking changes in a comparison intended to attribute one cause.

## Three baseline repetitions

For R01, R02 and R03, restore the same approved initial isolated card/settings snapshot, start a fresh capture before boot, cold boot without a savestate, stop at the defined first stable screen, close the VM normally, and hash capture/log/card outputs. Record every input and screen transition with UTC and relative timing. Do not infer an HTTP/account/game protocol simply from a port number.

| Run | Start UTC | Profile/config/card hashes | Raw capture ID/hash | First stable screen and elapsed time | Outcome |
|---|---|---|---|---|---|
| R01 | NOT RUN | Pending | None | Unobserved | NOT RUN |
| R02 | NOT RUN | Pending | None | Unobserved | NOT RUN |
| R03 | NOT RUN | Pending | None | Unobserved | NOT RUN |

If capture fails, routing is uncertain, an external service would be contacted unexpectedly, a real login is requested, or a snapshot differs, stop that run and record the reason. Correct setup before repeating; do not manufacture a successful result from logs alone. Absence of DNS packets may reflect backend behavior or capture coverage, not absence of resolver calls.

## Required result and E01 handoff

Retain immutable raw capture bytes, screen/state timeline, runtime/config provenance, source/output hashes, tool versions and all deviations. An individual observation is bounded to that run; repeated/differential evidence supports broader claims. Do not promote static observations or port guesses into CONFIRMED — client/protocol.

E00 closes only when the profile is complete and the three baseline captures have been reviewed. E01 then records bootstrap/DNAS timing; E02 isolates compatibility changes, followed by E03 discovery. Protocol Implementation Gate remains CLOSED. MOTD HTML formatting, login attempts, gameplay, persistence selection and implementation are outside this run card.
